import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic appBar = AppBar(
      title: const Text('Your chat?'),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/FZbNxD8iEq5cxtRUtPo4/messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/FZbNxD8iEq5cxtRUtPo4/messages')
              .add({
                'text': 'This was added by clicking the button xd'
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
