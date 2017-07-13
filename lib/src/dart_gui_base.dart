// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'events/add_element_event.dart';
import 'events/eventbase.dart';
import 'gui_isolate.dart' as iso;
import 'models/label.dart';
import 'models/modelbase.dart';

import 'package:dart_sdl/dart_sdl.dart';

class GuiWindow {
  Rectangle _rect;
  ReceivePort _receivePort;
  SendPort _sendPort;
  Stream _stream;

  GuiWindow(String title, this._rect) {
    _receivePort = new ReceivePort();
    _stream = _receivePort.asBroadcastStream();
    _stream.listen(dataFromIsolate);
  }

  init() async {
    await Isolate.spawn(iso.main, _receivePort.sendPort);
    _sendPort = await _stream.first;
  }

  dataFromIsolate(dynamic message) {}

  void sendEvent(Event event) {
    _sendPort.send(event);
  }

  void addElement(ModelBase element) {
    sendEvent(new AddElementEvent(element));
  }

  void updateElement(ModelBase element) {}

  void addLabel(String text, Point<int> position) {
    addElement(new Label(this, position, text));
  }
}
