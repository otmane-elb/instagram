import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final  datePublished;
  final String postUrl;
  final String profImage;
  final likes;
  const Post(
      {required this.description,
      required this.uid,
      required this.postId,
      required this.username,
      required this.datePublished,
      required this.postUrl,
      required this.likes,
      required this.profImage});
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'uid': uid,
      'postId': postId,
      'username': username,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
      'likes': likes,
    };
  }

  static Post fromsnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data();
    if (snapshot != null && snapshot is Map<String, dynamic>) {
      return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        username: snapshot['username'],
        datePublished: snapshot['datePublished'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes'],
      );
    } else {
      throw Exception('Invalid snapshot data');
    }
  }
}
