// Copyright 2017 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "generator.h"

#include <google/protobuf/stubs/logging.h>
#include <google/protobuf/stubs/strutil.h>

#include <algorithm>
#include <iterator>
#include <limits>
#include <string>

#include "proto/firebase_rules_options.pb.h"

#define RULES_FILE "firestore.rules"

using google::protobuf::StrCat;
using google::protobuf::StripSuffixString;

const std::vector<std::string> global_fields = {"_force_update"};

namespace google {
namespace firebase {
namespace rules {
namespace experimental {

namespace {

struct RulesContext {};

std::string StripPrefix(const std::string &str, const std::string &prefix) {
  if (prefix.size() <= str.size() && str.substr(0, prefix.size()) == prefix) {
    return str.substr(prefix.size());
  } else {
    return str;
  }
}

std::string SanitizeName(const std::string &name) {
  // Strip leading '.' characters.
  std::string sanitized_name = StripPrefix(name, ".");
  for (size_t i = 0; i < sanitized_name.size(); ++i) {
    if (sanitized_name[i] == '.') {
      sanitized_name[i] = '_';
    }
  }
  return sanitized_name;
}

void ReturnIndent(protobuf::io::Printer &printer) {
  printer.Indent();
}

void ReturnOutdent(protobuf::io::Printer &printer) {
  printer.Outdent();
}

std::string GetMessageName(const protobuf::Descriptor *message) {
  const auto &file_options =
      message->file()->options().GetExtension(rules_gen::firebase_rules);
  if (file_options.full_package_names()) {
    return SanitizeName(message->full_name());
  } else {
    return SanitizeName(
        StripPrefix(message->full_name(), message->file()->package()));
  }
}

std::string GetEnumName(const protobuf::EnumDescriptor *enumeration) {
  const auto &file_options =
      enumeration->file()->options().GetExtension(rules_gen::firebase_rules);
  if (file_options.full_package_names()) {
    return SanitizeName(enumeration->full_name());
  } else {
    return SanitizeName(
        StripPrefix(enumeration->full_name(), enumeration->file()->package()));
  }
}

std::vector<std::string> RequiredFields(const protobuf::Descriptor *message) {
  std::vector<std::string> required;
  const auto &msg_options = message->options().GetExtension(rules_gen::message);
  const auto msg_required = msg_options.required();
  for (int i = 0; i < message->field_count(); ++i) {
    const auto *field = message->field(i);
    const auto &field_options = field->options().GetExtension(rules_gen::field);
    if ((msg_required || field->is_required() || field_options.required()) &&
        field->containing_oneof() == nullptr) {
      required.push_back(field->lowercase_name());
    }
  }
  return required;
}

std::vector<std::string> OptionalFields(
    const protobuf::Descriptor *message,
    const std::vector<std::string> &required) {
  std::vector<std::string> optional = global_fields;
  for (int i = 0; i < message->field_count(); ++i) {
    const auto *field = message->field(i);
    if (std::count(required.begin(), required.end(), field->lowercase_name())) {
      continue;
    }
    if ((field->is_optional() || field->is_repeated()) &&
        field->containing_oneof() == nullptr) {
      optional.push_back(field->lowercase_name());
    }
  }
  return optional;
}

std::vector<std::vector<std::string>> OneOfFields(
    const protobuf::Descriptor *message) {
  std::vector<std::vector<std::string>> oneofs;
  for (int i = 0; i < message->oneof_decl_count(); ++i) {
    std::vector<std::string> oneof_names;
    const auto *oneof_decl = message->oneof_decl(i);
    for (int j = 0; j < oneof_decl->field_count(); ++j) {
      oneof_names.push_back(oneof_decl->field(j)->lowercase_name());
    }
    oneofs.push_back(oneof_names);
  }
  return oneofs;
}

std::string ToString(std::vector<std::string> vec) {
  std::string result = "[";
  for (const auto &elem : vec) {
    result.push_back('\'');
    result.append(elem);
    result.append("',");
  }
  if (vec.empty()) {
    result.push_back(']');
  } else {
    result[result.size() - 1] = ']';
  }
  return result;
}

bool FieldsRespectOneOfs(
    const std::vector<std::string> &fields,
    const std::vector<std::vector<std::string>> &oneof_fields) {
  for (const auto &oneofs : oneof_fields) {
    int count = 0;
    for (const auto &oneof_name : oneofs) {
      auto pos = std::find(fields.begin(), fields.end(), oneof_name);
      if (pos != fields.end()) {
        ++count;
      }
    }
    if (count > 1) {
      return false;
    }
  }
  return true;
}

std::vector<std::vector<std::string>> GenerateAllKCombinations(
    const std::vector<std::string> &vec, size_t k) {
  std::vector<std::vector<std::string>> result;
  if (k > 0) {
    for (size_t i = 0; i < vec.size() - k + 1; ++i) {
      const auto &t = vec[i];
      std::vector<std::string> temp = vec;  // Make a copy
      auto it = temp.begin();
      std::advance(it, i + 1);
      temp.erase(temp.begin(), it);
      auto temp_result = GenerateAllKCombinations(temp, k - 1);
      for (auto &temp_item : temp_result) {
        temp_item.push_back(t);
        result.push_back(temp_item);
      }
    }
  } else {
    std::vector<std::string> empty;
    result.push_back(empty);
  }
  return result;
}

std::vector<std::vector<std::string>> AllFieldCombinations(
    const std::vector<std::string> &required_fields,
    const std::vector<std::string> &optional_fields,
    const std::vector<std::vector<std::string>> &oneof_fields) {
  std::vector<std::vector<std::string>> combos;
  // Add all possible optional and oneof fields, throw out invalid combos
  // before adding to the final set.
  std::vector<std::string> all_opt_fields = optional_fields;
  for (const auto &oneof : oneof_fields) {
    all_opt_fields.insert(all_opt_fields.end(), oneof.begin(), oneof.end());
  }
  size_t k = optional_fields.size() + oneof_fields.size();
  const auto &k_combos = GenerateAllKCombinations(all_opt_fields, k);
  for (const auto &combo : k_combos) {
    std::vector<std::string> fields_combo = required_fields;  // Make a copy
    fields_combo.insert(fields_combo.end(), combo.begin(), combo.end());
    if (FieldsRespectOneOfs(fields_combo, oneof_fields)) {
      combos.push_back(fields_combo);
    }
  }
  return combos;
}

template <typename S>
bool IsLastIteration(S idx, S size) {
  return idx + 1 >= size;
}

}  // namespace

bool RulesGenerator::Generate(const protobuf::FileDescriptor *file,
                              const std::string &parameter,
                              protobuf::compiler::GeneratorContext *context,
                              std::string *error) const {
  std::string filename;
  if (parameter == "bazel" || true) {
    filename = StrCat(StripSuffixString(file->name(), ".proto"), ".pb.rules");
  } else {
    filename = RULES_FILE;
  }
  protobuf::io::Printer printer(context->Open(filename), '$');

  // Start by adding a comment
  printer.Print("// @@START_GENERATED_FUNCTIONS@@\n");

  for (int i = 0; i < file->message_type_count(); ++i) {
    const auto *message = file->message_type(i);
    if (!GenerateMessage(message, printer, error, true)) {
      return false;
    }
  }

  for (int i = 0; i < file->enum_type_count(); ++i) {
    const auto *enumeration = file->enum_type(i);
    if (!GenerateEnum(enumeration, printer, error)) {
      return false;
    }
  }

  // Skip any RPC services...

  // End by finishing that comment
  printer.Print("// @@END_GENERATED_FUNCTIONS@@\n");
  return true;
}

bool RulesGenerator::GenerateMessage(const protobuf::Descriptor *message,
                                     protobuf::io::Printer &printer,
                                     std::string *error,
                                     bool permissive) const {
  if (message->options().map_entry()) {
    return true;
  }
  const auto &options = message->options().GetExtension(rules_gen::message);
  printer.Print("function is$name$Message$permissive$(resource) {\n", "name",
                GetMessageName(message), "permissive",
                permissive ? "Permissive" : "");
  printer.Indent();
  printer.Print("return ");
  ReturnIndent(printer);
  // Validate properties
  const auto &required_fields = RequiredFields(message);
  const auto &optional_fields = OptionalFields(message, required_fields);
  const auto &oneof_fields = OneOfFields(message);
  if (!permissive) {
    printer.Print("is$name$Message$permissive$(resource)", "name",
                  GetMessageName(message), "permissive", "Permissive");
    auto combinations =
        AllFieldCombinations(required_fields, optional_fields, oneof_fields);
    if (!combinations.empty()) {
      printer.Print(" &&\n(");
    }
    for (size_t i = 0; i < combinations.size(); ++i) {
      const auto &combo = combinations[i];
      printer.Print("resource.keys().hasOnly($properties$)", "properties",
                    ToString(combo));
      if (IsLastIteration(i, combinations.size())) {
        printer.Print(")");
      } else {
        printer.Print(" ||\n");
      }
    }
  } else {
    printer.Print("resource.keys().hasAll($properties$)", "properties",
                  ToString(required_fields));
    // Validate inner types
    if (message->field_count() > 0) printer.Print(" &&\n");

    for (int i = 0; i < message->field_count(); ++i) {
      if (!GenerateField(message->field(i), printer, error, permissive)) {
        return false;
      }
      if (!IsLastIteration(i, message->field_count())) {
        printer.Print(" &&\n");
      }
    }
    if (options.has_validate()) {
      printer.Print(" &&\n($validate$)", "validate", options.validate());
    }
  }
  printer.Print(";");
  ReturnOutdent(printer);
  printer.Outdent();
  printer.Print("\n}\n");
  if (!permissive) {
    return true;
  }
  // Handle inner messages & enums
  for (int i = 0; i < message->nested_type_count(); ++i) {
    if (!GenerateMessage(message->nested_type(i), printer, error, true)) {
      return false;
    }
  }
  for (int i = 0; i < message->enum_type_count(); ++i) {
    if (!GenerateEnum(message->enum_type(i), printer, error)) {
      return false;
    }
  }
  return GenerateMessage(message, printer, error, false);
}

bool RulesGenerator::GenerateEnum(const protobuf::EnumDescriptor *enumeration,
                                  protobuf::io::Printer &printer,
                                  std::string *error) const {
  const auto &options =
      enumeration->options().GetExtension(rules_gen::firebase_rules_enum);
  printer.Print("function is$name$Enum(resource) {\n", "name",
                GetEnumName(enumeration));
  printer.Indent();
  printer.Print("return ");
  ReturnIndent(printer);
  for (int i = 0; i < enumeration->value_count(); ++i) {
    const auto *enum_value = enumeration->value(i);
    if (options.string_values()) {
      printer.Print("resource == '$value$'", "value", enum_value->name());
    } else {
      printer.Print("resource == $value$", "value",
                    std::to_string(enum_value->number()));
    }
    if (!IsLastIteration(i, enumeration->value_count())) {
      printer.Print(" ||\n");
    }
  }
  printer.Print(";");
  ReturnOutdent(printer);
  printer.Outdent();
  printer.Print("\n}\n");
  return true;
}

bool RulesGenerator::GenerateField(const protobuf::FieldDescriptor *field,
                                   protobuf::io::Printer &printer,
                                   std::string *error, bool permissive) const {
  const auto &options = field->options().GetExtension(rules_gen::field);
  const auto &msg_options =
      field->containing_type()->options().GetExtension(rules_gen::message);
  printer.Print("((");
  if ((field->is_optional() || field->is_repeated()) && !options.required() &&
      !msg_options.required()) {
    printer.Print(
        "!resource.keys().hasAny(['$name$']) || resource.$name$ == null) || (",
        "name", field->lowercase_name());
  }
  if (field->is_repeated() && !field->is_map()) {
    // We should validate the type inside the list, but currently we cannot
    // do that :(
    printer.Print("resource.$name$ is list", "name", field->lowercase_name());
  }
  if (field->is_map()) {
    // https://github.com/google/protobuf/blob/d3537c/src/google/protobuf/descriptor.proto#L463-L484
    if (!GenerateMap(field, printer, error)) {
      return false;
    }
  }
  if (!field->is_repeated()) {
    std::map<std::string, std::string> vars = {
        {"permissive", permissive ? "Permissive" : ""}};
    vars.insert({"name", field->lowercase_name()});
    if (options.reference_type() &&
        field->type() != protobuf::FieldDescriptor::TYPE_STRING) {
      *error = "references must be of type string";
      return false;
    }
    switch (field->type()) {
      case protobuf::FieldDescriptor::TYPE_DOUBLE:
      case protobuf::FieldDescriptor::TYPE_FLOAT:
        // TODO(rockwood): Do we need anything special for "Nan" or
        // "Infinity"?
        vars.insert({"type", "number"});
        printer.Print(vars, "resource.$name$ is $type$");
        break;
      case protobuf::FieldDescriptor::TYPE_INT64:
      case protobuf::FieldDescriptor::TYPE_SINT64:
      case protobuf::FieldDescriptor::TYPE_SFIXED64:
        vars.insert({"type", "int"});
        vars.insert(
            {"min", std::to_string(std::numeric_limits<int64_t>::min())});
        vars.insert(
            {"max", std::to_string(std::numeric_limits<int64_t>::max())});
        printer.Print(vars,
                      "resource.$name$ is $type$ && resource.$name$ >= $min$ "
                      "&& resource.$name$ <= $max$");
        break;
      case protobuf::FieldDescriptor::TYPE_UINT64:
      case protobuf::FieldDescriptor::TYPE_FIXED64:
        vars.insert({"type", "int"});
        vars.insert(
            {"min", std::to_string(std::numeric_limits<uint64_t>::min())});
        // TODO(rockwood): According to the following guide, large numbers
        // can be strings as well. Can we handle this?
        // https://developers.google.com/protocol-buffers/docs/proto3#json
        // Anything over max int64 can't be represented in JSON.
        vars.insert(
            {"max", std::to_string(std::numeric_limits<int64_t>::max())});
        printer.Print(vars,
                      "resource.$name$ is $type$ && resource.$name$ >= $min$ "
                      "&& resource.$name$ <= $max$");
        break;
      case protobuf::FieldDescriptor::TYPE_INT32:
      case protobuf::FieldDescriptor::TYPE_SINT32:
      case protobuf::FieldDescriptor::TYPE_SFIXED32:
        vars.insert({"type", "int"});
        vars.insert(
            {"min", std::to_string(std::numeric_limits<int32_t>::min())});
        vars.insert(
            {"max", std::to_string(std::numeric_limits<int32_t>::max())});
        printer.Print(vars,
                      "resource.$name$ is $type$ && resource.$name$ >= $min$ "
                      "&& resource.$name$ <= $max$");
        break;
      case protobuf::FieldDescriptor::TYPE_UINT32:
      case protobuf::FieldDescriptor::TYPE_FIXED32:
        vars.insert({"type", "int"});
        vars.insert(
            {"min", std::to_string(std::numeric_limits<uint32_t>::min())});
        vars.insert(
            {"max", std::to_string(std::numeric_limits<uint32_t>::max())});
        printer.Print(vars,
                      "resource.$name$ is $type$ && resource.$name$ >= $min$ "
                      "&& resource.$name$ <= $max$");
        break;
      case protobuf::FieldDescriptor::TYPE_BOOL:
        vars.insert({"type", "bool"});
        printer.Print(vars, "resource.$name$ is $type$");
        break;
      case protobuf::FieldDescriptor::TYPE_STRING:
        if (options.reference_type()) {
          vars.insert({"type", "path"});
        } else {
          vars.insert({"type", "string"});
        }
        printer.Print(vars, "resource.$name$ is $type$");
        break;
      case protobuf::FieldDescriptor::TYPE_BYTES:  // Base64 encoded strings.
        vars.insert({"type", "string"});
        printer.Print(vars, "resource.$name$ is $type$");
        break;
      case protobuf::FieldDescriptor::TYPE_GROUP:
        *error = "Groups are not supported.";
        return false;
      case protobuf::FieldDescriptor::TYPE_MESSAGE:
        if (field->message_type()->full_name() == "google.protobuf.Timestamp") {
          vars.insert({"type", "timestamp"});
          printer.Print(vars, "resource.$name$ is $type$");
        } else if (field->message_type()->full_name() ==
                   "common.DocumentReferenceProto") {
          vars.insert({"type", "path"});
          printer.Print(vars, "resource.$name$ is $type$");
        } else if (field->message_type()->full_name() == "common.LatLng") {
          vars.insert({"type", "latlng"});
          printer.Print(vars, "resource.$name$ is $type$");
        } else {
          vars.insert({"type", GetMessageName(field->message_type())});
          printer.Print(vars, "is$type$Message$permissive$(resource.$name$)");
        }
        break;
      case protobuf::FieldDescriptor::TYPE_ENUM:
        vars.insert({"type", GetEnumName(field->enum_type())});
        printer.Print(vars, "is$type$Enum(resource.$name$)");
        break;
    }
  }
  if (options.not_empty()) {
    assert(protobuf::FieldDescriptor::TYPE_STRING);
    std::map<std::string, std::string> vars;
    vars.insert({"name", field->lowercase_name()});
    printer.Print(vars, " && resource.$name$.trim().size() > 0");
  }
  if (options.is_http()) {
    assert(protobuf::FieldDescriptor::TYPE_STRING);
    std::map<std::string, std::string> vars;
    vars.insert({"name", field->lowercase_name()});
    printer.Print(vars, " && resource.$name$.matches('^http[s]?://.+')");
  }
  if (options.auth_user()) {
    std::map<std::string, std::string> vars;
    vars.insert({"name", field->lowercase_name()});
    printer.Print(vars, " && resource.$name$ == authUserDoc()");
  }
  if (options.has_validate()) {
    printer.Print(" && ($validate$)", "validate", options.validate());
  }
  printer.Print(")");
  bool nullable =
      (!options.has_nullable() && msg_options.nullable()) || options.nullable();
  if (nullable) {
    printer.Print(" || resource.$name$ == null", "name",
                  field->lowercase_name());
  }
  printer.Print(")");
  return true;
}

bool RulesGenerator::GenerateMap(const protobuf::FieldDescriptor *map_field,
                                 protobuf::io::Printer &printer,
                                 std::string *error) const {
  const auto *map = map_field->message_type();
  if (map->field_count() != 2) {
    *error = "Please use the map<> syntax to create maps!";
    return false;
  }
  const auto *key_field = map->FindFieldByName("key");
  if (key_field == nullptr) {
    *error = "Please use the map<> syntax to create maps!";
    return false;
  }
  const auto *value_field = map->FindFieldByName("value");
  if (value_field == nullptr) {
    *error = "Please use the map<> syntax to create maps!";
    return false;
  }
  if (key_field->type() != protobuf::FieldDescriptor::TYPE_STRING) {
    *error = "Firestore only supports `string` keys in maps.";
    return false;
  }
  // We should validate the values inside the map, but we currently cannot do
  // that :(
  printer.Print("resource.$name$ is map", "name", map_field->lowercase_name());
  return true;
}

}  // namespace experimental
}  // namespace rules
}  // namespace firebase
}  // namespace google
