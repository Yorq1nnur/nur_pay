import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nur_pay/data/models/network_response.dart';
import 'package:nur_pay/data/models/user_cards_model.dart';
import 'package:nur_pay/utils/constants/app_constants.dart';

class UserCardsRepo {
  Future<NetworkResponse> insertCard(UserCardsModel userCardsModel) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(
            AppConstants.cards,
          )
          .add(
            userCardsModel.toJson(),
          );
      await FirebaseFirestore.instance
          .collection(
            AppConstants.cards,
          )
          .doc(
            documentReference.id,
          )
          .update({
        "cardId": documentReference.id,
      });
      return NetworkResponse(data: 'success');
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Future<NetworkResponse> updateCard(UserCardsModel userCardsModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            AppConstants.cards,
          )
          .doc(
            userCardsModel.cardId,
          )
          .update(
            userCardsModel.toJsonForUpdate(),
          );
      return NetworkResponse(data: 'success');
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteCard(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            AppConstants.cards,
          )
          .doc(
            docId,
          )
          .delete();
      return NetworkResponse(data: 'success');
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Stream<List<UserCardsModel>> getCardsByUserId(String userId) =>
      FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .where(
            "userId",
            isEqualTo: userId,
          )
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => UserCardsModel.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          );

  Stream<List<UserCardsModel>> getCardsFromDb() => FirebaseFirestore.instance
      .collection(AppConstants.cardsDb)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => UserCardsModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );
}
