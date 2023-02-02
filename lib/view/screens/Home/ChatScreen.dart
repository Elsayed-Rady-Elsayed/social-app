import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/controller/home/HomeCubit.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';
import 'package:socialapp/view/screens/Home/chatDetailsScreen.dart';
import 'package:socialapp/view/widgets/Divider.dart';
import 'package:socialapp/view/widgets/NavigateTo.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..GetUsers(),
      child: BlocConsumer<HomeCubit, HomeAppStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return HomeCubit.get(context).users.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        To(context, route: ChatDetailsScreen(HomeCubit.get(context).users[index]));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  HomeCubit.get(context).users[index].image!),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        HomeCubit.get(context)
                                            .users[index]
                                            .name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => divider(),
                  itemCount: HomeCubit.get(context).users.length);
        },
      ),
    );
  }
}
