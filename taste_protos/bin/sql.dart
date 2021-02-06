import 'dart:io';

import 'package:taste_protos/parse/parser.dart';
import 'package:taste_protos/taste_protos.dart';

final project = Platform.environment['TASTE_PROD'];

String _sql(CollectionType t, String _type) => """
select 
  split(document_name, '(default)/documents/')[offset(1)] as _path,
  event_id as _event_id,
  timestamp as _timestamp,
  operation as _operation,
  ${SqlDef.fromFieldMap(parse(t), [])} 
from `$project.firestore_export.${t.name}_raw${_type.isEmpty ? '_latest' : '_changelog'}`
""";

extension on String {
  String get escape => this == 'following' ? '`$this`' : this;
}

class SqlDef {
  static String fromFieldMap(Map<String, Field> fields, List<String> prefix) {
    final indentation = List.filled(prefix.length * 2, ' ').join('');
    return '\n$indentation' +
        fields.entries
            .entryMap((name, field) => _field(name, field, prefix))
            .join(',\n$indentation') +
        '\n$indentation';
  }

  static String _arrayField(Field field, List<String> prefix) =>
      '(select array_agg(${_field(null, field, [])}) from unnest(${array(prefix)}) as data)';

  static String _field(String name, Field info, List<String> prefix) {
    String sqlDef() {
      prefix = [...prefix, name].withoutEmpties;
      return info.when(
        timestamp: () {
          final field = scalar([...prefix, '_seconds'], type: 'int64');
          return 'timestamp_seconds(cast($field as int64))';
        },
        reference: () => scalar(prefix),
        geoPoint: () {
          final latitude =
              scalarFloat([...prefix, '_latitude']) + ' as latitude';
          final longitude =
              scalarFloat([...prefix, '_longitude']) + ' as longitude';
          return 'struct($latitude, $longitude)';
        },
        integer: () => scalarInt(prefix),
        string: () => scalar(prefix),
        float: () => scalarFloat(prefix),
        boolean: () => scalarBool(prefix),
        enumeration: (_) => scalar(prefix),
        list: (field) => _arrayField(field, prefix),
        message: (fields) => 'struct(${fromFieldMap(fields, prefix)})',
        struct: () => struct(prefix),
      );
    }

    return '${sqlDef()} ${name == null ? '' : 'as ${name.escape}'}';
  }

  static String scalar(List<String> prefix, {String type = 'string'}) {
    final inner = "json_extract_scalar(data, '\$.${prefix.join('.')}')";
    if (type == 'string') {
      return inner;
    }
    return 'cast($inner as $type)';
  }

  static String scalarBool(List<String> prefix) {
    return scalar(prefix, type: 'bool');
  }

  static String scalarFloat(List<String> prefix) {
    return scalar(prefix, type: 'float64');
  }

  static String scalarInt(List<String> prefix) {
    return scalar(prefix, type: 'int64');
  }

  static String array(List<String> prefix) {
    return "json_extract_array(data, '\$.${prefix.join('.')}')";
  }

  // Just extract as JSON string if type is Struct (unknown fields).
  static String struct(List<String> prefix) {
    return "json_extract(data, '\$.${prefix.join('.')}')";
  }
}

void main() async {
  print(project);
  assert(project.isNotEmpty);
  final allTables = {
    CollectionType.food_finder_actions,
    CollectionType.photos,
    CollectionType.algolia_records,
    CollectionType.bookmarks,
    CollectionType.comments,
    CollectionType.discover_items,
    CollectionType.daily_tasty_votes,
    CollectionType.favorites,
    CollectionType.followers,
    CollectionType.likes,
    CollectionType.restaurants,
    CollectionType.users,
    CollectionType.insta_posts,
    CollectionType.badges,
    CollectionType.reviews,
    CollectionType.home_meals,
    CollectionType.google_reviews,
    CollectionType.yelp_reviews,
  }.cartesian({'', '_changelog'});
  for (final tuple in allTables) {
    final t = tuple.a;
    final type = tuple.b;
    final table = 'firestore_export.${t.name}${type}';
    final show =
        await Process.run('bq', ['--project_id', project, 'show', table]);
    print([show.stdout, show.stderr, show.exitCode]);
    if (show.exitCode == 0) {
      final rm =
          await Process.run('bq', ['--project_id', project, 'rm', '-f', table]);
      print([rm.stdout, rm.stderr, rm.exitCode]);
    }
    print('getting sql for $t $type');
    print('fields:\n\n');
    print(SqlDef.fromFieldMap(parse(t), []));
    print('\nCreating bq table...');
    final result = await Process.run('bq', [
      '--project_id',
      project,
      'mk',
      '--nouse_legacy_sql',
      '--view',
      '${_sql(t, type)}',
      table
    ]);
    print([result.stdout, result.stderr, result.exitCode]);
    if (result.exitCode > 0) {
      return;
    }
  }
}
