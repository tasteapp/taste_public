import 'package:taste_protos/extensions.dart';
import 'package:test/test.dart';

extension on Iterable<ZipTuple<int, int>> {
  List<List<int>> get fix => listMap((x) => [x.a, x.b]);
}

void main() {
  test('tiling', () {
    expect(
        <List<num>>[
          [37, -122, 1, 2],
          [-37, -122, 1, 2],
          [37, 122, 1, 2],
          [-37, 122, 1, 2],
          [37, -122, 2, 2],
          [37, -122, 3, 2],
          [37, -122, 7, 2],
          [37.758495, -122.426469, 19, 1],
          [37.758495, -122.426469, 19, 50],
          [37.758495, -122.426469, 19, 30],
          [37.314202, -121.792076, 11, 14000],
        ].map((x) => tiles(x[0], x[1], x[2], x[3])),
        [
          {'0,0,1'},
          {'0,1,1'},
          {'1,0,1'},
          {'1,1,1'},
          {'0,1,2'},
          {'1,3,3'},
          {'20,49,7'},
          {'83847,202678,19'},
          {
            '83846,202679,19',
            '83847,202679,19',
            '83848,202679,19',
            '83846,202678,19',
            '83847,202678,19',
            '83848,202678,19',
            '83846,202677,19',
            '83847,202677,19',
            '83848,202677,19',
          },
          {
            '83847,202679,19',
            '83847,202678,19',
          },
          {
            '330,795,11',
            '331,795,11',
            '330,794,11',
            '331,794,11',
            '330,793,11',
            '331,793,11',
          }
        ]);
  });
  test('chunk', () {
    expect([1, 4, 5, 6].chunk(4), [
      [1, 4, 5, 6]
    ]);
    expect([1, 4, 5, 6].chunk(10), [
      [1, 4, 5, 6]
    ]);
    expect([1, 4, 5, 6].chunk(1), [
      [1],
      [4],
      [5],
      [6]
    ]);
    expect([1, 4, 5, 6].chunk(2), [
      [1, 4],
      [5, 6],
    ]);
    expect([1, 4, 5, 6].chunk(3), [
      [1, 4, 5],
      [6],
    ]);
    expect(() => [1].chunk(0), throwsA(anything));
  });
  test('future-where', () async {
    expect(await [2, 5, 6, 7, 8].futureWhere((x) async => x.isEven), [2, 6, 8]);
  });
  test('distinct-on', () {
    expect(10.times.map((x) => x + 2).distinctOn((x) => x % 2), [2, 3]);
    expect(10.times.map((x) => x + 2).distinctOn((x) => x % 3), [2, 3, 4]);
  });
  test('quantize', () {
    expect(10.quantize(3), 9);
    expect(10.quantize(3, up: true), 12);
    expect(9.quantize(3), 9);
    expect(9.quantize(3, up: true), 9);
  });
  test('quantize–date', () {
    expect(DateTime(2000, 1, 1, 1, 1, 23).quantize(5.seconds),
        DateTime(2000, 1, 1, 1, 1, 25));
    expect(DateTime(2000, 1, 1, 1, 1, 23).quantize(4.seconds),
        DateTime(2000, 1, 1, 1, 1, 24));
  });
  test('zip', () {
    expect([1, 2].zip([3, 4]).fix, [
      [1, 3],
      [2, 4]
    ]);
    expect([1, 2].zip([3]).fix, [
      [1, 3],
    ]);
    expect([1].zip([3, 4]).fix, [
      [1, 3],
    ]);
    expect([1].zip([3, 4], nullPad: true).fix, [
      [1, 3],
      [null, 4]
    ]);
    expect([1, 2].zip([3], nullPad: true).fix, [
      [1, 3],
      [2, null]
    ]);
  });
  test('tuple-sort', () {
    expect(
        [
          [1, 0, 1, 3],
          [1, 0, 0, 4],
          [0, 1, 1, 5]
        ].tupleSort(identity),
        [
          [0, 1, 1, 5],
          [1, 0, 0, 4],
          [1, 0, 1, 3],
        ]);
  });
  test('test', () {
    expect([11, 5, 6, 23, 2, 3].max(identity), 23);
    expect([11, 5, 6, 23, 2, 3].max((i) => -i), 2);
    expect([11, 5, 6, 23, 2, 3].min(identity), 2);
    expect([11, 5, 6, 23, 2, 3].min((i) => -i), 23);
    expect({'a': 1, 'b': 1}.entries.tupleSort((e) => [e.value, e.key]).keys,
        ['a', 'b']);
    expect({'b': 1, 'a': 1}.entries.tupleSort((e) => [e.value, e.key]).keys,
        ['a', 'b']);
    expect({'a': 1, 'b': -1}.entries.tupleSort((e) => [e.value, e.key]).keys,
        ['b', 'a']);
    expect({'a': 1, 'b': 1}.entries.tupleMax((e) => [e.value, e.key]).key, 'b');
    expect(
        {'a': 1, 'b': -1}.entries.tupleMax((e) => [e.value, e.key]).key, 'a');
    expect(
        {'a': 1, 'b': 1}.entries.tupleMax((e) => [-e.value, e.key]).key, 'b');
    expect(
        {'a': 1, 'b': -1}.entries.tupleMax((e) => [-e.value, e.key]).key, 'b');
    expect({'a': 1, 'b': 1}.entries.tupleMax((e) => [e.key, e.value]).key, 'b');
    expect(
        {'a': 1, 'b': -1}.entries.tupleMax((e) => [e.key, e.value]).key, 'b');

    expect({'a': 1, 'b': 1}.entries.tupleMin((e) => [e.value, e.key]).key, 'a');
    expect(
        {'a': 1, 'b': -1}.entries.tupleMin((e) => [e.value, e.key]).key, 'b');
    expect(
        {'a': 1, 'b': 1}.entries.tupleMin((e) => [-e.value, e.key]).key, 'a');
    expect(
        {'a': 1, 'b': -1}.entries.tupleMin((e) => [-e.value, e.key]).key, 'a');
    expect({'a': 1, 'b': 1}.entries.tupleMin((e) => [e.key, e.value]).key, 'a');
    expect(
        {'a': 1, 'b': -1}.entries.tupleMin((e) => [e.key, e.value]).key, 'a');
    expect(<int>[].tupleSort((i) => [i]), isEmpty);
    expect(<int>[].tupleSort((i) => []), isEmpty);
    expect(<int>[].tupleMax((i) => [i]), isNull);
    expect(<int>[].tupleMax((i) => []), isNull);
  });
}
