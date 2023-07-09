import 'package:cloud_firestore/cloud_firestore.dart';

class Commant {
  final String description;
  final String uid;
  final String commentId;
  final String postId;

  final String username;
  final datePublished;
  final String profImage;
  final likes;
  const Commant(
      {required this.description,
      required this.uid,
      required this.commentId,
      required this.postId,
      required this.username,
      required this.datePublished,
      required this.likes,
      required this.profImage});
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'uid': uid,
      'commentId': commentId,
      'postId': postId,
      'username': username,
      'datePublished': datePublished,
      'profImage': profImage,
      'likes': likes,
    };
  }

  static Commant fromsnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data();
    if (snapshot != null && snapshot is Map<String, dynamic>) {
      return Commant(
        description: snapshot['description'],
        uid: snapshot['uid'],
        commentId: snapshot['commentId'],
        postId: snapshot['postId'],
        username: snapshot['username'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes'],
      );
    } else {
      throw Exception('Invalid snapshot data');
    }
  }
}
