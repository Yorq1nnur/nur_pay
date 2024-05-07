import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_event.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/screens/global_widgets/card_container.dart';
import 'package:nur_pay/screens/global_widgets/show_simple_dialog.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({
    super.key,
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<UserCardsBlock>().add(
            GetUserCardEvent(
              userId: FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
    );
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: BlocConsumer<UserCardsBlock, UserCardsState>(
        listenWhen: (p, c) => p.formStatus != c.formStatus,
        builder: (context, state) {
          methodPrint(
            "CURRENT USER CARDS LENGTH: ${state.userCards.length}",
          );
          return Scaffold(
            appBar: AppBar(
              actions: [
                Ink(
                  height: 30.w,
                  width: 30.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                    color: Colors.blueGrey.withOpacity(
                      0.2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.addNewCardRoute,
                      );
                    },
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: AppColors.black,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
                10.getW(),
              ],
              centerTitle: true,
              title: const Text(
                "My cards",
              ),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                state.userCards.length,
                (index) => CardContainer(
                  cardType: cardTypes[state.userCards[index].type],
                  cardNumber: state.userCards[index].cardNumber,
                  cardHolderName: state.userCards[index].cardHolder,
                  expireDate: state.userCards[index].expireDate,
                  colors: gradientColors[int.parse(
                    state.userCards[index].color,
                  )],
                  amount: state.userCards[index].balance.toString(),
                  voidCallback: () {},
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ShowSimpleDialog(
                            onSubmit: () {
                              context.read<UserCardsBlock>().add(
                                    DeleteUserCardEvent(
                                      userCard: state.userCards[index],
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            title: "WARNING!!!",
                            subTitle: "CONFIRM TO DELETE!?",
                          );
                        });
                  },
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, UserCardsState state) {
          if (state.statusMessage == 'deleted') {
            showToast(
              context: context,
              message: "DELETED SUCCESSFULLY",
            );
            context.read<UserCardsBlock>().add(
                  GetUserCardEvent(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                  ),
                );
          } else if (state.formStatus == FormStatus.error) {
            showToast(
              context: context,
              message: "Noma'lum xatolik",
            );
          }
        },
      ),
    );
  }
}
