import 'package:flutter_test/flutter_test.dart';
import 'package:taste/screens/review/tokenizer.dart';

void main() {
  void topCheck(RegExp r, String s, List<String> matches) =>
      expect(r.allMatches(s).map((m) => m.group(0)).toList(), matches,
          reason: [r, s, matches].toString());
  group('token', () {
    test("tag", () {
      void check(String s, List<String> matches) =>
          topCheck(tagRegex, s, matches);
      check('miss', []);
      check('#howdy', ['#howdy']);
      check('#howdy asdfasdf asd #two', ['#howdy', '#two']);
      check('#howdy asdf adsasafdad#middle asdfasdf asd #two',
          ['#howdy', '#middle', '#two']);
      check('#howdy#ho💡dy2 #howdy@jack#howdy#delivery #cheatday', [
        '#howdy',
        '#ho',
        '💡dy2',
        '#howdy',
        '@jack',
        '#howdy',
        '#delivery',
        '#cheatday'
      ]);
    });
    test("emoji", () {
      void check(String s, List<String> matches) =>
          topCheck(emojiRegex, s, matches);
      check('miss', []);
      check('🇬🇷', ['🇬🇷']);
      check('🇬🇷🇬🇷', ['🇬🇷', '🇬🇷']);
      check('🇬🇷 🇬🇷', ['🇬🇷', '🇬🇷']);
      check(' 🇬🇷 #cheatday', ['🇬🇷', '#cheatday']);
      check('🇬🇷 🇬🇷@ignoregarbage #unkwonn', ['🇬🇷', '🇬🇷']);
    });
    test("link", () {
      void check(String s, List<String> matches) =>
          topCheck(httpRegex, s, matches);
      check('miss', []);
      check('http://incomplete', []);
      check('http://complete.org', ['http://complete.org']);
      check(
          'http://complete.org/page#hash #hash ftp://junkhttps://www.trailing.com/page/page/moore-stoffff?query=param&another=param#anotherhash?keep-groiin the end',
          [
            'http://complete.org/page#hash',
            'https://www.trailing.com/page/page/moore-stoffff?query=param&another=param#anotherhash?keep-groiin'
          ]);
    });
    test('split', () {
      expect(tokenize('we do🇬🇷💙'), ['we do', '🇬🇷', '💙']);
      expect(
          tokenize(
              '#howdy🇬🇷🤤🤤 🇬🇷💡cool💡hi 💡💡hiagain@jacko@olga💡@jackohttps://cool.com/page#hashed #anotherhash asdf\n sdf asdfa\n sdf asd d safa#tagafterbreak'),
          [
            '#howdy',
            '🇬🇷',
            '🤤',
            '🤤',
            ' ',
            '🇬🇷',
            '💡cool',
            '💡hi',
            ' ',
            '💡',
            '💡hiagain',
            '@jacko',
            '@olga',
            '💡',
            '@jacko',
            'https://cool.com/page#hashed',
            ' ',
            '#anotherhash',
            ' asdf\n sdf asdfa\n sdf asd d safa',
            '#tagafterbreak',
          ]);
    });
  });
}
