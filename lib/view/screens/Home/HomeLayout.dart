import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/controller/home/HomeCubit.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';
import 'package:socialapp/view/screens/Home/NewpostScreen.dart';
import 'package:socialapp/view/widgets/NavigateTo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getPosts()..GetUserData(),
      child: BlocConsumer<HomeCubit, HomeAppStatus>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Iconsax.add),
            onPressed: () {
              To(context, route: NewPostScreen());
            },
          ),
          appBar: AppBar(
            title: Text(
              HomeCubit.get(context)
                  .titles[HomeCubit.get(context).currentIndex],
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
          ),
          body: HomeCubit.get(context)
              .screens[HomeCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: HomeCubit.get(context).currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              HomeCubit.get(context).ChangeTheCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.message), label: 'chat'),
              BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'users'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.setting), label: 'settings'),
            ],
          ),
        ),
      ),
    );
  }
}
