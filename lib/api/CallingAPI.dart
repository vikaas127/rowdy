import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:flutter/material.dart';

class CallingApi {
  /// Get firestore instance
  ///
  final _firestore = FirebaseFirestore.instance;

  /// Save match
  Future<void> _saveCall({
    required String docUserId,
    required String Call_to_UserId,
  }) async {
    await _firestore
        .collection(C_CONNECTIONS)
        .doc(docUserId)
        .collection(C_Call)
        .doc(Call_to_UserId)
        .set({TIMESTAMP: FieldValue.serverTimestamp()});
  }

  /// Get current user matches
  Future<List<DocumentSnapshot>> getCall() async {
    final QuerySnapshot query = await _firestore
        .collection(C_CONNECTIONS)
        .doc(UserModel().user.userId)
        .collection(C_Call)
        .orderBy(TIMESTAMP, descending: true)
        .get();
    return query.docs;
  }

  /// Delete match
  Future<void> deleteCall(String matchedUserId) async {
    // Delete match for current user
    await _firestore
        .collection(C_CONNECTIONS)
        .doc(UserModel().user.userId)
        .collection(C_Call)
        .doc(matchedUserId)
        .delete();
    // Delete the current user id from matched user list
    await _firestore
        .collection(C_CONNECTIONS)
        .doc(matchedUserId)
        .collection(C_Call)
        .doc(UserModel().user.userId)
        .delete();
  }

  /// Check if It's Match - when onother user already liked current one
  Future<void> checkCall(
      {required String userId, Call_to_UserId,required Function(bool) onMatchResult}) async {
    _firestore.collection(C_CONNECTIONS).doc(Call_to_UserId).collection(C_Call)
        .where(Called_USER_ID, isEqualTo: UserModel().user.userId)
        .where(C_Call, isEqualTo: userId)
        .get()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        /// It's Match - show dialog
        onMatchResult(true);

        /// Save match for current user
        await _saveCall(
          docUserId: UserModel().user.userId,
          Call_to_UserId: userId,
        );

        /// Save match copy for matched user
        await _saveCall(
          docUserId: userId,
          Call_to_UserId: UserModel().user.userId,
        );
        debugPrint('checkMatch() -> true');
      } else {
        onMatchResult(false);
        debugPrint('checkMatch() -> false');
      }
    }).catchError((e) {
      print('checkMatch() -> error: $e');
    });
  }
}
