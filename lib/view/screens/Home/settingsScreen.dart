import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/controller/home/HomeCubit.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';
import 'package:socialapp/view/widgets/NavigateTo.dart';

import 'EditProfile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..GetUserData(),
      child: BlocConsumer<HomeCubit, HomeAppStatus>(
        listener: (context, state) {},
        builder: (context, state) => HomeCubit.get(context).USERmodel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 210,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image(
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(HomeCubit.get(context)
                                      .USERmodel!
                                      .cover
                                      .toString())),
                            ),
                            CircleAvatar(
                              radius: 46,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 43,
                                backgroundImage: NetworkImage(
                                    HomeCubit.get(context).USERmodel!.image!),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        HomeCubit.get(context).USERmodel!.name!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        HomeCubit.get(context).USERmodel!.bio!,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [Text('120'), Text('posts')],
                            )),
                            Expanded(
                                child: Column(
                              children: [Text('10k'), Text('likes')],
                            )),
                            Expanded(
                                child: Column(
                              children: [Text('200'), Text('follow')],
                            )),
                            Expanded(
                                child: Column(
                              children: [Text('300'), Text('posts')],
                            )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                                  onPressed: () {}, child: Text('Add Post'))),
                          SizedBox(
                            width: 8,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                To(context, route: EditProfileScrees());
                              },
                              child: Icon(Iconsax.edit)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
