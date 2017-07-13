import 'dart:math';
import '../dart_gui_base.dart';
import 'modelbase.dart';

import 'package:dart_sdl/dart_sdl.dart';

class Label extends ModelBase {
  String text;

  Label(GuiWindow window, Point<int> position, this.text)
      : super(ModelType.Label, window, position);

  void prerender(SDL_Window sdlWindow, TTF_Font font) {
    var surface = TTF_RenderText(font, text, color);
    texture = SDL_CreateTextureFromSurface(sdlWindow, surface);
    SDL_FreeSurface(surface);
  }
}
