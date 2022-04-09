import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String userName;
  final String uid;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.userName,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'userName': userName,
      'uid': uid,
      'postId': postId,
      // 'photoUrl': photoUrl,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
      'likes': likes,
    };
  }

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot['description'],
      userName: snapshot['userName'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      // photoUrl: snapshot['photoUrl'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
    );
  }
}
