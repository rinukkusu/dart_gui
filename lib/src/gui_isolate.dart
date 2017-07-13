import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'events/add_element_event.dart';
import 'models/label.dart';
import 'models/modelbase.dart';
import 'package:dart_sdl/dart_sdl.dart';

SDL_Window window;
TTF_Font font;
int threadId;

SendPort sendPort;
ReceivePort receivePort;
Stream receiveStream;

List<ModelBase> elements;

void main(SendPort sender) {
  sendPort = sender;
  receivePort = new ReceivePort();
  receiveStream = receivePort.asBroadcastStream();
  sender.send(receivePort.sendPort);

  receiveStream.listen((data) {
    if (data is AddElementEvent) {
      if (data.element is Label) {
        (data.element as Label).prerender(window, font);
      }
      elements.add(data.element);
    }
  });

  receiveStream.first.then((_) {
    runSdl();
  });
}

void runSdl() {
  if (!SDL_Init(SDL_INIT_VIDEO)) return;

  TTF_Init();

  font = TTF_OpenFont("./fonts/arial.ttf", 14);

  window = SDL_CreateWindow(
      "test", new Rectangle(30, 30, 100, 100), SDL_WINDOW_RESIZABLE);
  print('windowCreated: ${window.data}');

  startRender();
}

void renderElements() {
  elements.forEach((element) {
    switch (element.type) {
      case ModelType.Label:
        {
          var label = element as Label;

          SDL_RenderCopy(
              window,
              label.texture,
              null,
              new Rectangle(label.position.x, label.position.y,
                  label.texture.width, label.texture.height));

          break;
        }
    }
  });
}

void startRender() {
  handleEvents();

  SDL_SetRenderDrawColor(window, SDL_Color.White);
  SDL_RenderClear(window);

  renderElements();

  SDL_RenderPresent(window);

  new Timer(new Duration(milliseconds: 1), startRender);
}

void handleEvents() {
  SDL_CommonEvent event;
  while ((event = SDL_PollEvent(window)) != null) {
    //print('${new DateTime.now()}: ${event.runtimeType}');

    if (event is SDL_QuitEvent) throw 'QUIT! :)';
    if (event is SDL_MouseMotionEvent) {}
  }
}
