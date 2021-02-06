import 'package:taste_cloud_functions/taste_functions.dart';

class City with EquatableMixin {
  City(this.city, this.country, this.state);
  final String city;
  final String country;
  final String state;

  @override
  List<Object> get props => [city, country, state];

  Map<String, String> get json =>
      {'city': city, 'country': country, 'state': state};

  @override
  String toString() => props.toString();
}
