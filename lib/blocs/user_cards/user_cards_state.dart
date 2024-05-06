import 'package:equatable/equatable.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/user_cards_model.dart';

class UserCardsState extends Equatable {
  final List<UserCardsModel> userCards;
  final List<UserCardsModel> db;
  final FormStatus formStatus;
  final String errorMessage;
  final String statusMessage;

  const UserCardsState({
    required this.formStatus,
    required this.userCards,
    required this.errorMessage,
    required this.statusMessage,
    required this.db,
  });

  UserCardsState copyWith({
    List<UserCardsModel>? userCards,
    List<UserCardsModel>? db,
    FormStatus? formStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserCardsState(
      db: db ?? this.db,
      formStatus: formStatus ?? this.formStatus,
      userCards: userCards ?? this.userCards,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [
        userCards,
        formStatus,
        errorMessage,
        statusMessage,
      ];
}
