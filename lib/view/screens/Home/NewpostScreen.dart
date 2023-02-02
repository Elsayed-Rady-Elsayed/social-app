import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/controller/home/HomeCubit.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..GetUserData(),
      child: BlocConsumer<HomeCubit, HomeAppStatus>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'add post',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (HomeCubit.get(context).PostImage != null) {
                      HomeCubit.get(context).uplodePostImage(
                          text: HomeCubit.get(context).postController.text,
                          dateTime: DateTime.now().toString());
                    } else {
                      HomeCubit.get(context).CreatePost(
                          text: HomeCubit.get(context).postController.text,
                          dateTime: DateTime.now().toString());
                    }
                  },
                  child: Text('post'))
            ],
          ),
          body: HomeCubit.get(context).USERmodel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                HomeCubit.get(context).USERmodel!.image!),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            HomeCubit.get(context).USERmodel!.name!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Expanded(
                          child: TextFormField(
                        controller: HomeCubit.get(context).postController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'what is in your mind?'),
                      )),
                      if (HomeCubit.get(context).PostImage != null)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image(
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: FileImage(
                                    HomeCubit.get(context).PostImage!)),
                            IconButton(
                                onPressed: () {
                                  HomeCubit.get(context).RemovePostimage();
                                },
                                icon: Icon(
                                  Iconsax.close_circle,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      Row(
                        children: [
                          Expanded(
                              child: TextButton(
                            onPressed: () {
                              HomeCubit.get(context).GetPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.image),
                                Text(
                                  'image',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          )),
                          Expanded(
                              child: TextButton(
                            onPressed: () {
                              HomeCubit.get(context).GetPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.tag),
                                Text(
                                  'tags',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
