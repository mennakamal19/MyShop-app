import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop_app/layout/cubit/cubit.dart';
import 'package:myshop_app/layout/cubit/states.dart';
import 'package:myshop_app/shared/components/components.dart';
import 'package:myshop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return Form(
          key: formKey,
          child: Column(
            children:
            [
              if(state is ShopLoadingUpdateUserState)
                LinearProgressIndicator(),
              const SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                controller: nameController,
                type: TextInputType.name,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'name must not be empty';
                  }
                  return null;
                },
                label: 'Name',
                prefix: Icons.person,
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'email must not be empty';
                  }

                  return null;
                },
                label: 'Email Address',
                prefix: Icons.email,
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                controller: phoneController,
                type: TextInputType.phone,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'phone must not be empty';
                  }

                  return null;
                },
                label: 'Phone',
                prefix: Icons.phone,
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultButton(
                function: ()
                {
                  if(formKey.currentState!.validate())
                  {
                    ShopCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                    );
                  }
                },
                text: 'update',
              ),
              const SizedBox(
                height: 20.0,
              ),
              defaultButton(
                function: () {
                  signOut(context);
                },
                text: 'Logout',
              ),
            ],
          ),
        );
      },
    );
  }
}