import 'dart:math';

import 'package:raylib/raylib.dart';
import 'package:raylib/src/modules/core/misc.dart';

void main() {
  var raylibPath = '.\\raylib.dll';

  initLibrary(windows: raylibPath);

  const screenWidth = 1280 ~/ 2;
  const screenHeight = 720 ~/ 2;
  const minFontSize = 20;
  const maxFontSize = 25;

  setConfigFlags(ConfigFlags.msaa4xHint);
  initWindow(screenWidth * 2, screenHeight * 2, 'Hello Raylib!');
  setTargetFPS(60);

  const text = 'Welcome to Raylib-Dart!';

  var fontSize = minFontSize;

  var time = 0.0;
  var zoomMult = 1.0;

  final camera = Camera2D(
      offset: Vector2(screenWidth.toDouble(), screenHeight.toDouble()),
      target: Vector2(screenWidth.toDouble(), screenHeight.toDouble()));

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

    beginDrawing();
    clearBackground(Color.black);

    beginMode2D(camera);
    drawCircle(screenWidth, screenHeight, 40, Color.red);
    drawText(
      text,
      screenWidth - measureText(text, fontSize) ~/ 2,
      screenHeight - 10,
      fontSize,
      Color.yellow,
    );
    endMode2D();

    drawFPS(32, 32);
    drawText('Press up/down arrrows to scale', 32, screenHeight * 2 - 40, 40,
        Color.darkGray);

    endDrawing();
  }

  closeWindow();
}
