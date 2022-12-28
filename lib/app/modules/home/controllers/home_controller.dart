import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educate_io/app/models/teacher_model.dart';
import 'package:educate_io/app/routes/app_pages.dart';
import 'package:educate_io/app/services/auth/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<Teacher> teachers = [
    Teacher(
      "https://scontent.fsof11-1.fna.fbcdn.net/v/t31.18172-8/21950058_534869006844669_6945425416141678541_o.jpg?_nc_cat=101&ccb=1-7&_nc_sid=174925&_nc_ohc=jFdDcuF4g3QAX9atVLX&tn=KtONFRTBWX1fCcTX&_nc_ht=scontent.fsof11-1.fna&oh=00_AfCfSyWS5ZQREK_95UO2B6UsbmSIQQJhWpWLuhFr9xOvtA&oe=63C2A37D",
      "Петър Желев",
      70,
      "Аз съм Петър Желев. Роден съм и се намирам в Бургас. Елате и ме изнаселете",
      ["Програмист", "Сертифиран педофил"],
      "Учител",
    ),
    Teacher(
      "https://scontent.fsof11-1.fna.fbcdn.net/v/t1.6435-9/89824552_2952344278155746_5720414663200473088_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=730e14&_nc_ohc=FyGA3iBo-KwAX8enAwM&_nc_ht=scontent.fsof11-1.fna&oh=00_AfCIH1hDM3PTkkpkcIA9iMRqj__Qi4zSvHcWxSMruCVDOQ&oe=63C2B929",
      "Самвел Матинян",
      90,
      "Здр, малки идиотчета, аз съм Самвел и се намирам във Варна. Обичам да играя шах с малки деца за да ги изнасилвам, Най-голямата ми жертва е Калоян от Бургас и създателя на това приложение",
      ["Програмист", "Сертифиран Sex offender"],
      "Учител",
    ),
    Teacher(
      "https://scontent.fsof11-1.fna.fbcdn.net/v/t31.18172-8/10003816_1499542633607086_9109329851444695853_o.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=WYFJ3wouTFkAX9XsxKY&_nc_ht=scontent.fsof11-1.fna&oh=00_AfAnmmJlKI4xXBdcIHP37T1pi5nUD2gSacAiU8UT2pTk_Q&oe=63C2C24F",
      "Петър Петров",
      60,
      "Обичам малки деца",
      ["Програмист", "Сертифиран Sex offender", "Сертифиран педофил"],
      "Учител",
    ),
    Teacher(
      "https://scontent.fsof11-1.fna.fbcdn.net/v/t31.18172-8/26685457_282701098923361_2465119173584930180_o.jpg?_nc_cat=105&ccb=1-7&_nc_sid=174925&_nc_ohc=y-K30rjDBB8AX-WaRZp&_nc_ht=scontent.fsof11-1.fna&oh=00_AfBdX0IP8SOkGApd5MdJRiGXVh-r2ogzjarQclzBmNnOVQ&oe=63C7B27A",
      "Станимир Ламбов",
      70,
      "Дано ме изнасили ученика ми",
      ["Програмист", "Педофил"],
      "Учител",
    )
  ];

  void showProfileSettings() {
    HapticFeedback.selectionClick();
    showDialog(
      context: Get.context!,
      builder: (context) => customDialog(context),
    );
  }

  Future<Map<String, String>?> getUserData() async {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print("null user");
      return null;
    }
    String uid = currentUser.uid;

    // Get the document snapshot for the current user
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      return {};
    }

    // Get the name and photo url from the data
    String name = data['name'] ?? "";
    String photoUrl = data['photoUrl'] ?? "";
    // If there is no photo url, generate the initials from the name
    if (photoUrl == null || photoUrl.isEmpty) {
      List<String> nameParts = name.split(' ');
      String initials = '';
      for (String part in nameParts) {
        initials += part[0];
      }
      name = initials;
    }

    // Return a map with the name and photo url
    return {'name': name, 'photoUrl': photoUrl};
  }
}

Widget customDialog(BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Настройки на профила",
              style: context.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              label: const Text("Настройки на профила"),
              icon: const Icon(Icons.settings),
              onPressed: () => Get.toNamed(
                Routes.PROFILE_SETTINGS,
                preventDuplicates: false,
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Излез от профила"),
              onPressed: () {
                FirebaseAuthService.logOut();
                Get.back();
              },
            )
          ],
        ),
      ),
    );
