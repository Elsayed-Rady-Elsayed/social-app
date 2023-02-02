import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/controller/home/HomeCubit.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';
import 'package:socialapp/model/Home/PostModel.dart';
import 'package:socialapp/view/screens/Home/NewpostScreen.dart';
import 'package:socialapp/view/widgets/Divider.dart';
import 'package:socialapp/view/widgets/NavigateTo.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getPosts()
        ..GetUserData(),
      child: BlocConsumer<HomeCubit, HomeAppStatus>(
        listener: (context, state) {},
        builder: (context, state) => HomeCubit.get(context).USERmodel == null &&
                HomeCubit.get(context).posts.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewPostMethod(context),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return PostItemMethod(
                              context, HomeCubit.get(context).posts[index],index);
                        },
                        separatorBuilder: (context, index) => divider(),
                        itemCount: HomeCubit.get(context).posts.length),
                  )
                ],
              ),
      ),
    );
  }

  NewPostMethod(context) {
    return InkWell(
      onTap: () {
        To(context, route: NewPostScreen());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                              HomeCubit.get(context).USERmodel!.image!),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'what are you thinking about ?',
                          style: TextStyle(color: Colors.grey.withOpacity(.7)),
                        )
                      ],
                    )),
                  ],
                ),
                const Text(''),
                divider(),
                 Container(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                          child: MaterialButton(
                        height: 20,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Row(
                          children:const [
                            Icon(
                              Iconsax.camera,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Image')
                          ],
                        ),
                      )),
                      Expanded(
                          child: MaterialButton(
                        height: 20,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Row(
                          children:const [
                            Icon(
                              Iconsax.tag,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Tags')
                          ],
                        ),
                      )),
                      Expanded(
                          child: MaterialButton(
                        height: 20,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Row(
                          children:const [
                            Icon(
                              Iconsax.document,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Document  ')
                          ],
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card PostItemMethod(BuildContext context, PostModel model,int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage(model.image!),
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
                            model.name!,
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon:const Icon(Icons.more_horiz))
              ],
            ),
            divider(),
            Text(
              model.text!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black.withOpacity(.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            if (model.postImage != "")
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(model.postImage!)),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                children: [
                  Expanded(
                      child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      HomeCubit.get(context)
                          .LikePost(HomeCubit.get(context).postids[index]);
                    },
                    child: Row(children: [
                      const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        HomeCubit.get(context).likes[index].toString(),
                      )
                    ]),
                  )),
                  Expanded(
                      child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:const [
                          Icon(
                            Icons.comment_outlined,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '150 comments',
                          )
                        ]),
                  )),
                ],
              ),
            ),
            divider(),
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(model.image!),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'write your comment..........',
                      style: TextStyle(color: Colors.grey.withOpacity(.7)),
                    )
                  ],
                )),
                Row(
                  children: const[
                    Icon(Icons.favorite_outline, color: Colors.red),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Like')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
