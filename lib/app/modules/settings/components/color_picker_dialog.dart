import 'package:educate_io/app/controllers/main_controller.dart';
import 'package:educate_io/app/services/get_storage_service.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  final mainController = Get.find<MainController>();
  var color = Color(GetStorageService().read("color") ??
      Theme.of(Get.context!).colorScheme.primary.value);

  Future<void> changeThemeColor(
      {bool dynamicColor = false, bool save = false}) async {
    mainController.dynamicColor.value = dynamicColor;
    await GetStorageService().writeSettings("dynamic", dynamicColor);

    if (dynamicColor) {
      Get.back();
      return;
    }

    mainController.darkColor.value =
        ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark);

    mainController.lightColor.value = ColorScheme.fromSeed(seedColor: color);
    if (save) {
      await GetStorageService().writeSettings("color", color.value);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: const Text("Цвят на темата"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: ColorPicker(
          pickersEnabled: const {
            ColorPickerType.accent: false,
            ColorPickerType.custom: false,
            ColorPickerType.wheel: true,
            ColorPickerType.primary: false,
          },
          wheelSquarePadding: 20,
          color: color,
          onColorChanged: (value) {
            setState(() {
              color = value;
            });
            changeThemeColor();
          },
          crossAxisAlignment: CrossAxisAlignment.center,
          wheelWidth: 25,
          showRecentColors: false,
          wheelDiameter: 400,
          enableShadesSelection: false,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () => changeThemeColor(save: true),
              child: const Text("Запази новия цвят"),
            ),
            ElevatedButton(
              onPressed: () => changeThemeColor(dynamicColor: true, save: true),
              child: const Text("Динамичен цвят"),
            ),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text("Отказ"),
            )
          ],
        ),
      ],
    );
  }
}
