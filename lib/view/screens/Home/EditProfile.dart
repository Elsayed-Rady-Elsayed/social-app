import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/controller/home/HomeCubit.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';
import 'package:socialapp/view/widgets/TextFormField.dart';
import 'dart:io';

import 'package:socialapp/view/widgets/button.dart';

class EditProfileScrees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..GetUserData(),
      child: BlocConsumer<HomeCubit, HomeAppStatus>(
          listener: (context, state) {},
          builder: (context, state) {
            return HomeCubit.get(context).USERmodel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back,color: Colors.black,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                HomeCubit.get(context).UpdateUser(
                                    bio: HomeCubit.get(context)
                                        .bioController
                                        .text,
                                    name: HomeCubit.get(context)
                                        .nameController
                                        .text);
                              },
                              child: Text('UPDATE'))
                        ],
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 210,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Image(
                                              height: 180,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              image: HomeCubit.get(context)
                                                          .CoverImage ==
                                                      null
                                                  ? NetworkImage(
                                                      HomeCubit.get(context)
                                                          .USERmodel!
                                                          .cover
                                                          .toString())
                                                  : FileImage(
                                                          HomeCubit.get(context)
                                                              .CoverImage!)
                                                      as ImageProvider),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              child: IconButton(
                                                onPressed: () {
                                                  HomeCubit.get(context)
                                                      .GetCoverImage();
                                                },
                                                icon:
                                                    const Icon(Iconsax.camera),
                                              )),
                                        )
                                      ],
                                    ),
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                          radius: 46,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 43,
                                            backgroundImage: HomeCubit.get(
                                                            context)
                                                        .profileImage ==
                                                    null
                                                ? NetworkImage(
                                                    HomeCubit.get(context)
                                                        .USERmodel!
                                                        .image!)
                                                : FileImage(
                                                        HomeCubit.get(context)
                                                            .profileImage!)
                                                    as ImageProvider,
                                          ),
                                        ),
                                        CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.blue,
                                            child: IconButton(
                                              onPressed: () {
                                                HomeCubit.get(context)
                                                    .GetProfileImage();
                                              },
                                              icon: const Icon(
                                                Iconsax.camera,
                                                size: 20,
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                              if(HomeCubit.get(context).profileImage!=null)
                              Expanded(child: Button(title: 'edit profile', press: (){
                                HomeCubit.get(context).uplodeProfileImage(name: HomeCubit.get(context).nameController.text, bio: HomeCubit.get(context).bioController.text);
                              })),
                               if(HomeCubit.get(context).CoverImage!=null)
                               Expanded(child: Button(title: 'edit covver', press: (){
                           HomeCubit.get(context).uplodecoverImage(name: HomeCubit.get(context).nameController.text, bio: HomeCubit.get(context).bioController.text);

                               }))
                                ],
                              ),

                              const SizedBox(
                                height: 16,
                              ),
                              TextFieldWithLable(
                                context,
                                controller:
                                    HomeCubit.get(context).bioController,
                                label: 'Bio',
                                validate: (v) {},
                                isPassword: false,
                                obsecure: false,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFieldWithLable(
                                context,
                                controller:
                                    HomeCubit.get(context).nameController,
                                label: 'name',
                                validate: (v) {},
                                isPassword: false,
                                obsecure: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
