import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/view_model/user_provider.dart';
import 'package:socialscan/views/profile/screens/edit_profile_screen.dart';

import '../../../models/user_model.dart';
import '../../../utils/frosted_glass_box.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String profession = '';
  String phoneNumber = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(
      context,
    ).userModel;
    final userProvider = Provider.of<UserProvider>(
      context,
    );
    // final nameController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FrostedGlassBox(
                  title: '${userModel!.firstName} ${userModel.lastName}',
                  subTitle: userModel.profession!,
                  theChild: Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProjectColors.mainPurple,
                    ),
                    child: userProvider.userModel!.image.isEmpty &&
                            userProvider.image == null
                        ? Center(
                            child: Text(
                              userModel.firstName.toString().substring(0, 1),
                              style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            // height: MediaQuery.of(context).size.width - 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: ClipOval(
                              child: userModel.image.isNotEmpty &&
                                          userProvider.image == null ||
                                      userProvider.image!.isEmpty
                                  ? Image.network(
                                      userModel.image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.memory(
                                      userProvider.image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                  ),
                  background: Center(
                    child: userModel.image.isNotEmpty &&
                            (userProvider.image == null ||
                                userProvider.image!.isEmpty)
                        ? Image.network(
                            userModel.image,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : userProvider.image != null &&
                                userProvider.image!.isNotEmpty
                            ? Image.memory(
                                userProvider.image!,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: ProjectColors.mainPurple,
                              ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // textTile(name),
                // const SizedBox(
                //   height: 5,
                // ),
                // // ReusableTextField(
                // //   // controller: nameController,
                // //   initialValue:
                // //       '${userModel.firstName} ${userModel.lastName}',
                // //   obscure: false,
                // //   iconButton: null,
                // //   onSaved: (val) {
                // //     firstName = val!;
                // //   },
                // //   onTap: () {},
                // // ),
                // Text(
                //   '${userModel.firstName} ${userModel.lastName}',
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //     color: ProjectColors.midBlack,
                //   ),
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
                // textTile('Profession'),
                // const SizedBox(
                //   height: 5,
                // ),
                // ReusableTextField(
                //   // controller: nameController,
                //   initialValue: userModel.profession,
                //   obscure: false,
                //   iconButton: null,
                //   onSaved: (val) {
                //     profession = val!;
                //   },
                //   onTap: () {},
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
                textTile(phone),
                const SizedBox(
                  height: 5,
                ),
                // ReusableTextField(
                //   // controller: nameController,
                //   initialValue: userModel.phoneNumber,
                //   obscure: false,
                //   iconButton: null,
                //   onSaved: (val) {
                //     phoneNumber = val!;
                //   },
                //   onTap: () {},
                // ),
                Text(
                  userModel.phoneNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ProjectColors.midBlack,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                textTile('Email'),
                const SizedBox(
                  height: 5,
                ),

                Text(
                  userModel.email,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ProjectColors.midBlack,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ButtonTile(text: save, boxRadius: 8),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: GestureDetector(
      //   onTap: () {
      //     // _formKey.currentState!.save();
      //     // FirebaseService()
      //     //     .updateProfile(
      //     //         firstName: firstName,
      //     //         lastName: lastName,
      //     //         profession: profession,
      //     //         phoneNumber: phoneNumber,
      //     //         email: email,
      //     //         image: userProvider.image!)
      //     //     .then(
      //     //       (value) => infoSnackBar(context, 'Profile Updated Successful',
      //     //           const Duration(milliseconds: 400), Colors.green),
      //     //     );
      //   Navigator.push(
      //     context,
      //     CupertinoPageRoute(
      //       builder: (_) => const EditProfileScreen(),
      //     ),
      //   );
      // },
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(
      //       horizontal: 10,
      //       vertical: 10,
      //     ),
      //     color: Colors.transparent,
      //     child: const ButtonTile(text: "Edit Profile", boxRadius: 8),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ProjectColors.mainPurple,
        elevation: 0.0,
        // shape: const RoundedRectangleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => const EditProfileScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  
  }

  Widget textTile(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ProjectColors.midBlack.withOpacity(0.4),
      ),
    );
  }
}
