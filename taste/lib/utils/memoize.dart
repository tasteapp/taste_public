/// Shorthand helper for lazily initializing and caching the result of a getter.
/// The two implementations below are identical from a behavior standpoint...
///
/// ```dart
/// class Barebones {
///   int get lazyX => _lazyX ??= 5;
///   int _lazyX;
/// }
/// ```
///
/// ```dart
/// class UsingMemoizer with Memoizer {
///   int get lazyX => memoize(() => 3, "lazyX");
/// }
mixin Memoizer {
  final _storage = {};
  T memoize<T>(T Function() fn, String tag) =>
      _storage.putIfAbsent(tag, fn) as T;
}
