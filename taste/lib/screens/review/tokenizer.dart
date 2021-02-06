import 'package:taste/screens/create_review/review/legal_taste_tags.dart';
import 'package:taste/utils/extensions.dart';

final httpRegex = RegExp(
    r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');
final tagRegex = RegExp(r'(@|#|💡)[^(@|#|💡|\s)]*');
final emojiRegex = RegExp('${kTasteTagsMap.keys.join('|')}');
final recipeHeaderRegex = RegExp('recipe:?\s*\n', caseSensitive: false);

/// Sequentially tokenize the original string [s] by "splitting" into chunks
/// found by each regexp in the list below. Once a match has been identified by
/// a regexp, it is considered fully parsed, and will not be split again.
///
/// Any chunk which has not found a match is eligible for the next round of
/// splitting. This allows for an http tokenizer to disallow a taste-tag
/// tokenizer from splitting out a "#" from within the link, while still
/// allowing the taste-tag parser to find unclaimed hashtags after the http
/// parser runs.
///
/// Each resulting token is just a string, which needs to be interpreted again
/// as something special, even if it matched from within this algorithm.
///
/// This algorithm guarantees that [output.join('') == s].
Iterable<String> tokenize(String s) => [
      httpRegex,
      emojiRegex,
      tagRegex,
      recipeHeaderRegex,
    ].fold(
        [ZipTuple(s, false)],
        //ignore: avoid_types_on_closure_parameters
        (Iterable<ZipTuple<String, bool>> previousTokens, pattern) =>
            // Create a set of new tokens for each input token.
            previousTokens.expand((pair) {
              if (pair.b) {
                // This was already parsed.
                return [pair];
              }
              final text = pair.a;
              final matches = pattern.allMatches(text);
              if (matches.isEmpty) {
                // No matches, return as-is for future rounds to parse.
                return [pair];
              }
              // Splits the chunks by match-ranges and marks the chunk as
              // "parsed" iff its start position is one of the `matches` start
              // positions.
              final starts = matches.map((m) => m.start);
              final ends = matches.map((m) => m.end);
              final hits = starts.zip(ends);
              final misses =
                  [0].followedBy(ends).zip(starts.followedBy([text.length]));
              return hits
                  .followedBy(misses)
                  .sorted((a) => a.a)
                  .where((a) => a.b > a.a)
                  .map((a) =>
                      ZipTuple(text.substring(a.a, a.b), starts.contains(a.a)));
            })).a;
