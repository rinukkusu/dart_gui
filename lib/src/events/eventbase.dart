enum EventType { AddElement }

abstract class Event<T> {
  final EventType type;

  Event(this.type);

  T fromJson(Map map) {}

  T _fromJsonInternal();
}
