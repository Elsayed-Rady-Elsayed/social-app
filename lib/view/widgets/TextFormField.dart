import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/controller/auth/cubit.dart';

TextFieldWithLable(
  context, {
  required String label,
  required TextEditingController controller,
  required var validate,
  obsecure = false,
  isPassword=  false
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              obscureText: obsecure,
              validator: validate,
              controller: controller,
              decoration: InputDecoration(
                  suffixIcon: isPassword
                      ? IconButton(
                          onPressed: () {
                            AuthCubit.get(context).ChangeObsecure();
                          },
                          icon: AuthCubit.get(context).obsecure?Icon(Icons.visibility,color: Colors.blue,):Icon(Icons.visibility_off,color: Colors.blue,),)
                      :null,
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none),
            ))
      ],
    );
