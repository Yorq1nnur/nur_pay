import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_event.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_state.dart';
import 'package:nur_pay/data/models/network_response.dart';
import 'package:nur_pay/data/repositories/user_cards_repo/user_cards_repo.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';
import '../../data/models/form_status.dart';
import '../../data/models/user_cards_model.dart';

class UserCardsBlock extends Bloc<UserCardsEvent, UserCardsState> {
  UserCardsBlock(this.userCardsRepo)
      : super(const UserCardsState(formStatus: FormStatus.pure)) {
    on<AddUserCardEvent>(_addUserCard);
    on<UpdateUserCardEvent>(_updateUserCard);
    on<DeleteUserCardEvent>(_deleteUserCard);
    on<GetUserCardEvent>(_listenUserCards);
    on<GetAllUserCardsEvent>(_listenAllCards);
  }

  final UserCardsRepo userCardsRepo;

  _addUserCard(AddUserCardEvent event, emit) async {
    methodPrint(
      "ADD USER CARD EVENT GA TUSHDI",
    );
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );
    methodPrint(
      state.formStatus,
    );

    NetworkResponse networkResponse = await userCardsRepo.insertCard(
      event.userCard,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        formStatus: FormStatus.showMessage,
        statusMessage: 'added',
      ));
      methodPrint(
        "ADD USER CARD EVENTDA SUCCESS GA TUSHDI",
      );
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
      methodPrint(
        "ADD USER CARD EVENTDA ERROR GA TUSHDI: ${networkResponse.errorText}",
      );
    }
  }

  _updateUserCard(UpdateUserCardEvent event, emit) async {
    methodPrint(
      "UPDATE USER CARD EVENT GA TUSHDI",
    );
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );
    methodPrint(
      state.formStatus,
    );

    NetworkResponse networkResponse = await userCardsRepo.updateCard(
      event.userCard,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.showMessage,
          statusMessage: 'updated',
        ),
      );
      methodPrint(
        "UPDATE USER CARD EVENTDA SUCCESS GA TUSHDI",
      );
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
      methodPrint(
        "UPDATE USER CARD EVENTDA ERROR GA TUSHDI: ${networkResponse.errorText}",
      );
    }
  }

  _deleteUserCard(DeleteUserCardEvent event, emit) async {
    methodPrint(
      "DELETE USER CARD EVENT GA TUSHDI",
    );
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );
    methodPrint(
      state.formStatus,
    );

    NetworkResponse networkResponse = await userCardsRepo.deleteCard(
      event.userCard.cardId,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.showMessage,
          statusMessage: 'deleted',
        ),
      );
      methodPrint(
        "DELETE USER CARD EVENTDA SUCCESS GA TUSHDI",
      );
    } else {
      emit(state.copyWith(
        formStatus: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
      methodPrint(
        "DELETE USER CARD EVENTDA ERROR GA TUSHDI: ${networkResponse.errorText}",
      );
    }
  }

  _listenUserCards(GetUserCardEvent event, Emitter emit) async {
    await emit.onEach(userCardsRepo.getCardsByUserId(event.userId),
        onData: (List<UserCardsModel> userCards) {
      emit(state.copyWith(
        userCards: userCards,
      ));
    });
  }

  _listenAllCards(GetAllUserCardsEvent event, Emitter emit) async {
    await emit.onEach(userCardsRepo.getCardsFromDb(),
        onData: (List<UserCardsModel> userCards) {
      emit(state.copyWith(
        userCards: userCards,
      ));
    });
  }
}
