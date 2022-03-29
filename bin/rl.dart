import 'dart:math';

import 'package:raylib/raylib.dart';
import 'package:raylib/src/modules/core/misc.dart';

void main() {
  var raylibPath = '.\\raylib.dll';

  initLibrary(windows: raylibPath);

  const halfWidth = 1280 ~/ 2;
  const halfHeight = 720 ~/ 2;
  const fontSize = 20;

  setConfigFlags(ConfigFlags.msaa4xHint);
  initWindow(halfWidth * 2, halfHeight * 2, 'Hello Raylib!');
  setTargetFPS(60);

  const msg = 'Welcome to Raylib-Dart!';
  String timeStr;

  var time = 0.0;
  var zoomMult = 1.0;

  final camera = Camera2D(
      offset: Vector2(halfWidth.toDouble(), halfHeight.toDouble()),
      target: Vector2(halfWidth.toDouble(), halfHeight.toDouble()));

  while (!windowShouldClose()) {
    //time += getFrameTime();
    time += 0.016;
    if (isKeyDown(KeyboardKey.up)) {
      zoomMult += 0.1;
    } else if (isKeyDown(KeyboardKey.down) && zoomMult >= 1.0) {
      zoomMult -= 0.1;
    }

    camera.zoom = (2.0 + sin(time) * 1.5) * zoomMult;
    camera.rotation = sin(time * 3) * 40;
    camera.zoom.clamp(0.5, 2.5);

    timeStr = DateTime.now().toString().split(' ')[1].split('.')[0];
    beginDrawing();
    clearBackground(Color.black);

    beginMode2D(camera);
    drawCircle(halfWidth, halfHeight, 40, Color.red);
    drawText(
      msg,
      halfWidth - measureText(msg, fontSize) ~/ 2,
      halfHeight - 10,
      fontSize,
      Color.yellow,
    );
    endMode2D();

    drawFPS(32, 32);
    drawText(timeStr, halfWidth * 2 - 32 - measureText(timeStr, 20), 32, 20,
        Color.darkGreen);
    drawText('Press up/down arrrows to scale', 32, halfHeight * 2 - 40, 40,
        Color.darkGray);

    endDrawing();
  }

  closeWindow();
}
