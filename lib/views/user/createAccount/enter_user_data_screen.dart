import 'package:chat_app/shared/components/shared_components.dart';
import 'package:chat_app/shared/style/colors.dart';
import 'package:chat_app/shared/validation/text_feild_validation.dart';
import 'package:chat_app/views/user/cubit/cubit.dart';
import 'package:chat_app/views/user/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/shared/components/user_components.dart';

class EnterUserDataScreen extends StatelessWidget {
  const EnterUserDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UserCubit cubit = UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: userAppBar(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              image: cubit.userImage == null
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/defaultImage.jpg"),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: FileImage(cubit.userImage!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              child: const CircleAvatar(
                                backgroundColor: primaryColor,
                                child:
                                    Icon(Icons.camera_alt, color: Colors.white),
                                maxRadius: 25,
                              ),
                              onTap: () {
                                cubit.pickProfileImage();
                              },
                            ),
                          ),
                        ],
                      ),
                      spaceBetween(size: 24),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            textInputField(
                              context: context,
                              controller: usernameController,
                              keyboard: TextInputType.name,
                              hintText: 'Enter Your Name',
                              prefixIcon: Icons.person_rounded,
                              validator: nameValidator,
                            ),
                          ],
                        ),
                      ),
                      spaceBetween(size: 24),
                      primaryButton(
                        text: 'Next',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.username = usernameController.text;
                            cubit.createNewUser(
                              phoneNumber: cubit.phoneNumber.replaceAll(" ", ""),
                              username: usernameController.text,
                              id: cubit.userId!,
                              context: context,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
