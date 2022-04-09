import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttergram/models/post.dart';
import 'package:fluttergram/resourses/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String userName,
    String profImage,
  ) async {
    String res = "Some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        userName: userName,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String uid, String postId, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
        likes.add(uid);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
