import '../models/modelbase.dart';
import 'eventbase.dart';

class AddElementEvent extends Event<AddElementEvent> {
  final ModelBase element;

  AddElementEvent(this.element) : super(EventType.AddElement);
}
