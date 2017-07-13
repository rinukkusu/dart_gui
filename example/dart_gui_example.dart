// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../lib/dart_gui.dart';
import 'dart:async';
import 'dart:math';

main() async {
  var window = new GuiWindow("test", new Rectangle(10, 10, 100, 100));
  await window.init();
  window.addLabel("hallo", const Point(10, 10));
}
