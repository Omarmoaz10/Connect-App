import 'package:connectapp/layout/cubit/cubit.dart';
import 'package:connectapp/layout/cubit/states.dart';
import 'package:connectapp/shared/component/components.dart';
import 'package:connectapp/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        return Scaffold(
          appBar: defaultAppbar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: "Update",
              ),
              const SizedBox(width: 15.0)
            ],
          ),
          body: SingleChildScrollView(
            // to make scrollable
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(
                                      4.0,
                                    ),
                                    topRight: Radius.circular(
                                      4.0,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${userModel.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getprofileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text
                                              );
                                    },
                                    text: "Upload Profile "),
                                if (state is SocialUserUpdateLoadingState)
                                const SizedBox(height: 5.0),
                                if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(width: 5.0),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      SocialCubit.get(context)
                                          .uploadCoverImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text
                                              );
                                    }, text: "Upload Cover "),
                                if (state is SocialUserUpdateLoadingState)
                                const SizedBox(height: 5.0),
                                if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(height: 20.0),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "name must be not empty";
                      }
                      return null;
                    },
                    label: "Name",
                    prefix: IconBroken.User,
                  ),
                  const SizedBox(height: 10.0),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "phone must be not empty";
                      }
                      return null;
                    },
                    label: "Phone",
                    prefix: IconBroken.Call,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    child: defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Bio must be not empty";
                        }
                        return null;
                      },
                      label: "Bio",
                      prefix: IconBroken.Info_Circle,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// values.xml
// <?xml version="1.0" encoding="utf-8"?>
// <resources>
//     <string name="default_web_client_id" translatable="false">350893502662-33ohg4mm0g0l0r4g54r6e85r2j4o9res.apps.googleusercontent.com</string>
//     <string name="gcm_defaultSenderId" translatable="false">350893502662</string>
//     <string name="google_api_key" translatable="false">AIzaSyAapVcIaBh0wJ-7Yi1dUonZLl-czCIekpQ</string>
//     <string name="google_app_id" translatable="false">1:350893502662:android:2caed52a40b954de30e7c7</string>
//     <string name="google_crash_reporting_api_key" translatable="false">AIzaSyAapVcIaBh0wJ-7Yi1dUonZLl-czCIekpQ</string>
//     <string name="google_storage_bucket" translatable="false">connectapp-3845e.appspot.com</string>
//     <string name="project_id" translatable="false">connectapp-3845e</string>
// </resources>