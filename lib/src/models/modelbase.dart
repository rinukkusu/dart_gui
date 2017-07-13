import '../dart_gui_base.dart';
import 'dart:math';
import 'package:dart_sdl/dart_sdl.dart';
import 'package:uuid/uuid.dart';

enum ModelType { Label }

abstract class ModelBase {
  final GuiWindow window;
  final String id;
  final ModelType type;

  SDL_Texture texture;

  Point<int> _position;
  Point<int> get position => _position;
  void set position(Point<int> v) {
    _position = v;
    window.updateElement(this);
  }

  SDL_Color _color;
  SDL_Color get color => _color;
  void set color(SDL_Color v) {
    _color = v;
    window.updateElement(this);
  }

  ModelBase(this.type, this.window,
      [this._position = const Point(0, 0), this._color = null])
      : id = new Uuid().v4() {
    if (_color == null) {
      _color = SDL_Color.Black;
    }
  }
}
