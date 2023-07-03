import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethodes {
  final FirebaseStorage storage = FirebaseStorage.instance;
  // add image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost, String uid) async {
    Reference ref = storage.ref().child(childName).child(uid);
    if (isPost) {
      String id = Uuid().v1();
      ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String url = await snap.ref.getDownloadURL();
    return url;
  }
}
