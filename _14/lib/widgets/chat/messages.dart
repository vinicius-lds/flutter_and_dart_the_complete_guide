import 'package:_14/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = (snapshot.data as dynamic).docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) {
            return MessageBubble(
              message: docs[index]['text'],
              userName: docs[index]['username'],
              userImage: docs[index]['userImage'],
              isMe: docs[index]['userId'] == currentUser.uid,
            );
          },
        );
      },
    );
  }
}
