import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educate_io/app/modules/chats/components/message_settings.dart';
import 'package:educate_io/app/modules/chats/models/message_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage(
      {super.key,
      required this.message,
      required this.ownMessage,
      required this.doc});

  final Message message;
  final bool ownMessage;
  final DocumentReference doc;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: ownMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            useSafeArea: true,
            builder: (context) => Stack(
              fit: StackFit.loose,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InteractiveViewer(
                    clipBehavior: Clip.none,
                    boundaryMargin: EdgeInsets.all(20),
                    maxScale: 5,
                    child: Hero(
                      tag: message.value,
                      child: CachedNetworkImage(
                        height: Get.height,
                        width: Get.width,
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: imageProvider,
                          ),
                        ),
                        imageUrl: message.value,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          );
        },
        onLongPress: () => showModalBottomSheet(
          context: context,
          builder: (context) => MessageSettings(
            doc: doc,
            ref: FirebaseStorage.instance.refFromURL(message.value),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Hero(
            tag: message.value,
            child: CachedNetworkImage(
              width: 250,
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: imageProvider,
                ),
              ),
              imageUrl: message.value,
            ),
          ),
        ),
      ),
    );
  }
}
