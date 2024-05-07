import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_bloc.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_event.dart';
import 'package:nur_pay/blocs/user_cards/user_cards_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/user_cards_model.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({
    super.key,
    required this.onPop,
  });

  final VoidCallback onPop;

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final TextInputType holderNameInputType = TextInputType.text;
  final TextInputType cardNameInputType = TextInputType.text;
  final TextInputType bankNameInputType = TextInputType.text;
  final TextInputType cardNumberInputType = TextInputType.number;
  final TextInputType amountInputType = TextInputType.number;
  final TextInputType expireDateInputType = TextInputType.datetime;

  List<TextInputType> inputTypes = [];
  final List<String> titles = [
    FirebaseAuth.instance.currentUser!.displayName ?? 'EGASI',
    "BANK NOMI:",
    "KARTA NOMI:",
    "KARTA RAQAMI:",
    "BALANSI:",
    "AMAL QILISH MUDDATI:",
  ];
  List<String> values = [
    FirebaseAuth.instance.currentUser!.displayName ?? 'EGASI',
    "",
    "",
    "",
    "",
    "",
  ];

  bool isMain = false;

  @override
  void initState() {
    _init();
    Future.microtask(
      () => context.read<UserCardsBlock>().add(
            GetUserCardEvent(
              userId: FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
    );
    super.initState();
  }

  _init() {
    inputTypes = [
      holderNameInputType,
      bankNameInputType,
      cardNameInputType,
      cardNumberInputType,
      amountInputType,
      expireDateInputType,
    ];
    methodPrint(
      FirebaseAuth.instance.currentUser!.displayName,
    );
  }

  final _formKey = GlobalKey<FormState>();
  int activeTypeIndex = -1;
  int activeColorIndex = -1;
  String cardType = '';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: AppColors.transparent),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.w,
              ),
              ZoomTapAnimation(
                onTap: () {
                  Navigator.pop(context);
                  widget.onPop.call();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 20.w,
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: Text(
            'ADD NEW CARD',
            style: AppTextStyle.interBold.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
        body: BlocConsumer<UserCardsBlock, UserCardsState>(
          listenWhen: (prev, current) =>
              current.formStatus == FormStatus.showMessage ||
              current.formStatus == FormStatus.error,
          listener: (context, state) {
            if (state.formStatus == FormStatus.showMessage) {
              Navigator.pop(context);
              state.copyWith(
                formStatus: FormStatus.pure,
              );
              widget.onPop.call();
            } else if (state.formStatus == FormStatus.error) {
              showToast(
                context: context,
                message: "THIS CARD ALREADY EXISTS!!!",
                color: Colors.red,
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...List.generate(
                            inputTypes.length,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 3.h,
                              ),
                              child: SizedBox(
                                height: 60.h,
                                child: TextFormField(
                                  enabled: index == 0 ? false : true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (v) {
                                    values[index] = v;
                                    setState(() {});
                                  },
                                  validator: (String? v) {
                                    if (index == 1) {
                                      if (v == null || v.length < 5) {
                                        return "ILTIMOS, BANK NOMINI TO'LIQ KIRITING!!!";
                                      }
                                    }
                                    if (index == 2) {
                                      if (v == null) {
                                        return "ILTIMOS, BANK NOMINI TO'LIQ KIRITING!!!";
                                      }
                                    }
                                    if (index == 3) {
                                      if (v == null ||
                                          v.length < 16 ||
                                          v.length > 16) {
                                        return 'KARTA RAQAMI 16 XONALIK BOLISHI KERAK!!!';
                                      }
                                    }
                                    if (index == 4) {
                                      if (v!.isEmpty) {
                                        return "ILTIMOS, KAMIDA 1000 UZS KIRITING!!!";
                                      } else {
                                        if (int.parse(v) < 1000) {
                                          return "BALANSINGIZDA KAMIDA 1000 UZS BO'LISHI KERAK!!!";
                                        }
                                      }
                                    }
                                    if (index == 5) {}
                                    return null;
                                  },
                                  style: AppTextStyle.interBold.copyWith(
                                    color: AppColors.black,
                                  ),
                                  keyboardType: inputTypes[index],
                                  textInputAction: index == 5
                                      ? TextInputAction.done
                                      : TextInputAction.next,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2.w,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ),
                                    ),
                                    hintText: titles[index],
                                    hintStyle: AppTextStyle.interBold.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ILTIMOS, KARTA TURINI TANLANG:",
                    style: AppTextStyle.interBold.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...List.generate(
                          cardTypes.length,
                          (index) => ZoomTapAnimation(
                            onTap: () {
                              activeTypeIndex = index;
                              cardType = cardTypes[index];
                              setState(() {});
                            },
                            child: Container(
                              height: 40.h,
                              width: 200.w,
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: activeTypeIndex == index
                                    ? Colors.redAccent
                                    : Colors.teal,
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  cardTypes[index],
                                  style: AppTextStyle.interBold.copyWith(
                                    color: activeTypeIndex == index
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    "ILTIMOS, KARTA RANGINI TANGLANG:",
                    style: AppTextStyle.interBold.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          gradientColors.length,
                          (index) => ZoomTapAnimation(
                            onTap: () {
                              activeColorIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5.w,
                              ),
                              height: activeColorIndex == index ? 50.w : 40.w,
                              width: activeColorIndex == index ? 50.w : 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: gradientColors[index],
                                ),
                              ),
                              child: Center(
                                child: activeColorIndex == index
                                    ? Center(
                                        child: SvgPicture.asset(
                                          AppImages.tick,
                                          width: 20.w,
                                          height: 20.h,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ASOSIY QILIB BELGILANSINMI?",
                        style: AppTextStyle.interBold.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      Switch(
                        value: isMain,
                        onChanged: (value) {
                          setState(() {
                            isMain = value;
                            debugPrint("\$\$\$\$\$\n$value\n\$\$\$\$\$");
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: Ink(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      onTap: () {
                        methodPrint(
                          "CURRENT USER ID: ${FirebaseAuth.instance.currentUser!.uid}",
                        );
                        methodPrint(
                          "CURRENT USER CARDS LENGTH: ${state.userCards.length}",
                        );
                        context.read<UserCardsBlock>().add(
                              GetUserCardEvent(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                              ),
                            );

                        bool isExists = false;
                        for (var element in state.userCards) {
                          if (element.cardNumber == values[3]) {
                            isExists = true;
                            break;
                          }
                        }
                        if (!isExists) {
                          UserCardsModel userCardsModel = UserCardsModel(
                            cardHolder: values[0],
                            cardNumber: values[3],
                            expireDate: formatDateWithSlash(
                              values[5],
                            ),
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            type: activeTypeIndex,
                            cvc: 'cvc',
                            icon: 'icon',
                            balance: double.parse(
                              values[4],
                            ),
                            bankName: values[1],
                            cardId: '',
                            color: activeColorIndex.toString(),
                            isMain: isMain,
                            cardName: values[2],
                          );
                          context.read<UserCardsBlock>().add(
                                AddUserCardEvent(
                                  userCard: userCardsModel,
                                ),
                              );
                        } else {
                          showToast(
                            context: context,
                            message: "THIS CARD ALREADY EXISTS",
                            color: Colors.red,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'ADD NEW CARD',
                          style: AppTextStyle.interBold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
