import 'package:crud_operation/config/app_string.dart';
import 'package:crud_operation/widgets.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel? user;
  final void Function(UserModel user)? onUpdate;

  const UserDetailScreen({super.key, this.user,this.onUpdate});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _username;
  String? _email;
  String? _phone;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _name = widget.user!.name;
      _username = widget.user!.username;
      _email = widget.user!.email;
      _phone = widget.user!.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? AppString.addUser : AppString.editUser),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              AllWidgets.customTextField(initialValue: _name, Error: AppString.errorName,labelText: 'Name'),
              AllWidgets.verticalSpace(),
              AllWidgets.customTextField(initialValue: _username, Error: AppString.errorUserNm,labelText: 'Username'),
              AllWidgets.verticalSpace(),
              AllWidgets.customTextField(initialValue: _email, Error:AppString.errorEmail,labelText: 'Email'),
              AllWidgets.verticalSpace(),
              AllWidgets.customTextField(initialValue: _phone, Error: AppString.errorNumber,labelText: 'Phone'),
              AllWidgets.verticalSpace(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final user = UserModel(
                      id: widget.user?.id,
                      name: _name,
                      username: _username,
                      email: _email,
                      phone: _phone,
                    );
                    widget.onUpdate!.call(user);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.user == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
