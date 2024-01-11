import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../constants/firestore_constants.dart';

class ChatUser extends Equatable {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String aboutMe;
  final String pushToken;

  const ChatUser(
      {required this.id,
      required this.photoUrl,
      required this.displayName,
      required this.phoneNumber,
      required this.aboutMe,
      required this.pushToken});

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? phoneNumber,
    String? email,
    String? pushToken,
  }) =>
      ChatUser(
        id: id ?? this.id,
        photoUrl: photoUrl ?? this.photoUrl,
        displayName: nickname ?? displayName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        aboutMe: email ?? aboutMe,
        pushToken: pushToken ?? this.pushToken,
      );

  Map<String, dynamic> toJson() => {
        FirestoreConstants.displayName: displayName,
        FirestoreConstants.photoUrl: photoUrl,
        FirestoreConstants.phoneNumber: phoneNumber,
        FirestoreConstants.aboutMe: aboutMe,
        FirestoreConstants.pushToken:pushToken,
      };
  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    String aboutMe = "";
    String pushToken = "";

    try {
      photoUrl = snapshot.get(FirestoreConstants.photoUrl);
      nickname = snapshot.get(FirestoreConstants.displayName);
      phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
      aboutMe = snapshot.get(FirestoreConstants.aboutMe);
      pushToken = snapshot.get(FirestoreConstants.pushToken);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
        id: snapshot.id,
        photoUrl: photoUrl,
        displayName: nickname,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe,
        pushToken: pushToken);
  }
  @override
  List<Object?> get props => [id, photoUrl, displayName, phoneNumber, aboutMe, pushToken];
}
