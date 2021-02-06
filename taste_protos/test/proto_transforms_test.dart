import 'package:taste_protos/taste_protos.dart';
import 'package:test/test.dart';

import 'fake_provider.dart';

void main() {
  setUp(testSetup);
  test('datetime', () {
    final date = DateTime(1980).toUtc();
    expect({'date': date}.ensureAs(DiscoverItem())['date'].d, date);
    expect(
        {'date': FakeTimestamp(date)}.ensureAs(DiscoverItem())['date'].d, date);
    expect({'date': date}.asProto(DiscoverItem()).date.toDateTime(), date);
  });
  test('big-timestamp', () {
    expect(
      {'project_code': '300002951'}.ensureAs(AppMetadata()),
      {'project_code': '300002951'},
    );
  });
  test('repeated simple', () {
    final map = {
      '_tags': ['f', 'asdf']
    };
    expect(
        ProtoTransforms.ensureAsMap(RestaurantMarkerCache(), map), equals(map));
  });
  test('repeated complex', () {
    final map = {
      'reviews': [
        {
          'reference': {'path': 'asgd'}
        },
        {
          'user': {'path': 'asgd'}
        }
      ]
    };
    expect(
        ProtoTransforms.ensureAsMap(RestaurantMarkerCache(), map), equals(map));
  });
  test('objectID to map', () {
    final proto = RestaurantMarkerCache();
    proto.objectID = 'asdf';
    expect(ProtoTransforms.toCallFnOutput(proto), equals({'objectID': 'asdf'}));
  });
  test('objectID casing weirdness', () {
    final map = {
      'objectID': 'asdf',
      '_tags': ['a', 'b'],
      '_geoloc': {'lat': 2, 'lng': -3},
      'top_review': {
        'user': {'thumbnail': 'fff'}
      },
      'reviews': [
        {
          'reference': {'path': 'asdf'},
          'photo': 'fdsa',
          'score': 123
        },
        {
          'user': {'path': 'asdf'},
          'photo': 'asdgfasdga',
          'score': 1521
        },
      ],
    };
    expect(
        ProtoTransforms.ensureAsMap(RestaurantMarkerCache(), map), equals(map));
  });
  test('unknown fields', () {
    expect(
        ProtoTransforms.ensureAsMap(RestaurantMarkerCache(), {
          '_tags': ['a', 'b'],
          'junk': {
            'ignore': {'all': 'of this'}
          }
        }),
        equals({
          '_tags': ['a', 'b'],
        }));
  });
  test('explicitEmpties', () {
    expect({'emojis': []}.ensureAs(Review()), isEmpty);
    expect({'emojis': <String>{}}.ensureAs(Review(), explicitEmpties: true),
        {'emojis': []});
    expect(
        {
          'comments': [
            {'junk': []}
          ]
        }.ensureAs(DiscoverItem()),
        {
          'comments': [{}]
        });
    expect(
        {
          'comments': [
            {'junk': []}
          ]
        }.ensureAs(DiscoverItem(), explicitEmpties: true),
        {
          'comments': [
            {'junk': []}
          ]
        });
  });
}
