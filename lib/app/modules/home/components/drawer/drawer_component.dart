import 'package:educate_io/app/modules/home/components/drawer/content/anon_content.dart';
import 'package:educate_io/app/modules/home/components/drawer/content/user_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({
    super.key,
  });

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.mediaQuery.padding.top + 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: FittedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_pin_circle,
                    size: 50,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EducateIO",
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        "От ученици за ученици",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Content
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                return const UserContent();
              }

              return const AnonContent();
            },
          ),
          SizedBox(
            height: Get.mediaQuery.padding.bottom,
          ),
        ],
      ),
    );
  }
}
