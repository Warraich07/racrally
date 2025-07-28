import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:racrally/views/team/controller/team_controller.dart';
import '../../../app_theme/app_theme.dart';
import '../../../app_widgets/custom_button.dart';
import '../../../app_widgets/custom_text_field.dart';
import '../../../constants/custom_validators.dart';
import '../../../utils/snackbar_utils.dart';
import '../../auth/widgets/custom_dropdown.dart';

class InvitePlayerSheet {
  static void show(BuildContext context,String teamId) {


    String? playerType;
    final emailController=TextEditingController();
    final TeamController teamController=Get.find();
    final GlobalKey<FormState> _formKey = GlobalKey();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                    color: AppTheme.primaryColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              width: 76,
                              height: 5,
                              color: AppTheme.dividerColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text("Invite Player", style: AppTheme.mediumHeadingStyle),
                        ),
                        const SizedBox(height: 18),
                        CustomTextField(
                          validator:  (value) => CustomValidator.email(value),
                          controller: emailController,
                          fieldName: "Email",
                          hintText: "Enter email address...",
                        ),
                        const SizedBox(height: 18),
                        CustomDropdownField(
                          validator:  (value) => CustomValidator.role(value),
                          fieldName: "Role",
                          hintText: "Select",
                          value: playerType,
                          items: const [
                            DropdownMenuItem(value: "Active Roaster", child: Text("Active Roaster")),
                            DropdownMenuItem(value: "Reserve Player", child: Text("Reserve Player")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              playerType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        CustomButton(
                          onTap: () {
                            if(_formKey.currentState!.validate()){
                              teamController.sendInvite(teamId,emailController.text.toString(), playerType=="Active Roaster"?"active_roaster":"reserve_player");
                              print(emailController.text.toString());
                              print(playerType!);
                              Get.back();
                              // teamController.isPlayerInvited.value=true;
                            }


                            // Get.toNamed(AppRoutes.teamDetail);
                            // SnackbarUtil.showSnackbar(
                            //   message: "Invite Sent",
                            //   type: SnackbarType.success,
                            // );
                          },
                          Text: "Invite Player",
                        ),
                        SizedBox(height: Platform.isIOS?20:0,)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}
