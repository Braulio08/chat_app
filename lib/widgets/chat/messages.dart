import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = snapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: documents?.length,
          itemBuilder: (context, index) => MessageBubble(
            message: documents?[index]['text'] ?? '',
            username: documents?[index]['username'] ?? '',
            isMe: documents?[index]['userId'] == user!.uid,
            key: ValueKey(documents?[index].id),
          ),
        );
      },
    );
  }
}
