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
            userImage: documents?[index]['userImage'] ?? '',
            message: documents?[index]['text'] ?? '',
            userName: documents?[index]['userName'] ?? '',
            isMe: documents?[index]['userId'] == user!.uid,
            key: ValueKey(documents?[index].id),
          ),
        );
      },
    );
  }
}
