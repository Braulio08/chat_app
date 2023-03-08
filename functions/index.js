const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
exports.myFunction = functions.firestore
    .document("chat/{message}")
    .onCreate((snap, context) => {
      const myTitle = snap.data().username == null ?
      "UserName" : snap.data().username;
      const myBody = snap.data().text == null ?
      "Message" : snap.data().text;
      return admin.messaging().send({
        notification: {
          title: myTitle,
          body: myBody,
        },
        topic: "chat",
      });
    });
