import 'package:conditional_builder/conditional_builder.dart';
import 'package:connectapp/layout/cubit/cubit.dart';
import 'package:connectapp/layout/cubit/states.dart';
import 'package:connectapp/models/social_user_model.dart';
import 'package:connectapp/modules/chat_details/chat_details_screen.dart';
import 'package:connectapp/shared/component/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          // Or   SocialCubit.get(context).users.length > 0
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length ,
          ),
          fallback: (context) =>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(
              userModel: model,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
             const SizedBox(
                width: 15.0
              ),
              Text(
                '${model.name}',
                style:const TextStyle(
                  height: 1.4
                ),
              ),
            ],
          ),
        ),
      );
}