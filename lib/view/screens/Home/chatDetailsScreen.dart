import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/consts.dart';
import 'package:socialapp/controller/home/HomeCubit.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';
import 'package:socialapp/model/Home/messageModel.dart';
import 'package:socialapp/model/auth/userModel.dart';
import 'package:socialapp/view/widgets/Divider.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  ChatDetailsScreen(this.model);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        HomeCubit.get(context).getMessages(reciever: model.uid!);
        return BlocConsumer<HomeCubit, HomeAppStatus>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: AppBAR(context),
            body: Column(children: [
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (uid ==
                                HomeCubit.get(context).messageModel[index].sender)
                              return recievermessage(HomeCubit.get(context).messageModel[index]);
                            else
                              return sendermessage(HomeCubit.get(context).messageModel[index]);
                          },
                          itemCount: HomeCubit.get(context).messageModel.length),
                    ),
                    WriteMessagePart(context)
                  ]),
          ),
        );
      }),
    );
  }

  Padding WriteMessagePart(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Expanded(
              child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: 'write your message....'),
          )),
          Container(
            child: MaterialButton(
              minWidth: 1,
              height: 50,
              color: Colors.blue,
              onPressed: () {
                HomeCubit.get(context).sendMessageme(
                    reciever: model.uid!,
                    text: controller.text,
                    dateTime: DateTime.now().toString());
              },
              child: Icon(
                Iconsax.send,
                color: Colors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }

  Align recievermessage(MessageModel messageModel) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(messageModel.text!),
          ),
        ),
      ),
    );
  }

  Align sendermessage(MessageModel messageModel) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(messageModel.text!),
          ),
        ),
      ),
    );
  }

  AppBar AppBAR(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 1,
      title: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(model.image!),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
