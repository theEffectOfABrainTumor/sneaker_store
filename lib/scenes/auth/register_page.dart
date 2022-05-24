import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_textfield_widget.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/bootom_sheet_anchor.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/roles_swither_widget.dart';
import '../../common/app_textstyles.dart';
import '../../core/user/roles.dart';
import '../../generated/l10n.dart';
import 'auth_bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Roles roleValue = Roles.buyer;
  bool isOnTap = true;

  Future<void> onTapRegister () async {

    context.read<AuthBloc>().add(RegisterUserEvent(
      login: loginController.text,
      password: passwordController.text,
      roles: roleValue,
    ));

    Navigator.of(context).pop();
  }

  void onTapRolesSwitcher () {
    setState(() {
      isOnTap = !isOnTap;
    });
    if (isOnTap) {
      setState(() {
        roleValue = Roles.buyer;
      });
    } else {
      setState(() {
        roleValue = Roles.seller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (BuildContext builder, ScrollController scrollController) {
        return Container(
            height: MediaQuery.of(context).size.height / 1.35,
            padding: const EdgeInsets.symmetric(horizontal: 35),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35),
                  topLeft: Radius.circular(35)),
              color: AppColors.backgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BottomSheetAnchor(margin: EdgeInsets.only(left: 140, right: 140, bottom: 10, top: 10),),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Text(
                    S.current.createAccount,
                    style: AppTextStyles.subTitleTextStyle,
                  ),
                ),
                RolesSwitcherWidget(
                  leftText: S.current.buyer,
                  rightText: S.current.seller,
                  backgroundColor: Colors.white.withOpacity(0.07),
                  floatingWidgetColor: Colors.blue,
                  backgroundTextStyle: AppTextStyles.backgroundRolesSwitcherTextStyle,
                  floatingWidgetTextStyle: AppTextStyles.floatingRolesSwitcherTextStyle,
                  height: MediaQuery.of(context).size.height / 17,
                  width: MediaQuery.of(context).size.width / 1.24,
                  onTap: onTapRolesSwitcher,
                ),
                SizedBox(height: MediaQuery.of(context).size.height/18,),
                AuthTextFieldWidget(
                  labelText: S.current.email,
                  controller: loginController,
                  keyboard: TextInputType.emailAddress,
                  isSuffixIcon: false,
                ),
                AuthTextFieldWidget(
                  labelText: S.current.password,
                  controller: passwordController,
                  keyboard: TextInputType.text,
                  isSuffixIcon: true,
                ),
                AuthButtonWidget(
                    margin: const EdgeInsets.only(top: 100, bottom: 40),
                    text: S.current.register,
                    onTap: onTapRegister,
                ),
              ],
            )
        );
      },
      expand: false,
      initialChildSize: 0.66,
    );
  }
}
