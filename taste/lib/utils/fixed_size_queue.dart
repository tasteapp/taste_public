import 'dart:collection';

class FixedSizeQueue<T> extends IterableMixin<T> {
  FixedSizeQueue(this.maxSize);
  final storage = ListQueue<T>();
  final int maxSize;

  void add(T t) {
    storage.addFirst(t);
    if (storage.length > maxSize) {
      storage.removeLast();
    }
  }

  T get head => storage.isEmpty ? null : storage.first;
  T get prior {
    final el = storage.skip(1).take(1);
    return el.isEmpty ? null : el.first;
  }

  void clear() => storage.clear();

  @override
  Iterator<T> get iterator => storage.iterator;
}
