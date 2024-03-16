import 'package:assets/models/contact_model.dart';
import 'package:assets/models/repository.dart';
import 'package:assets/screens/add_contact/widgets/universal_textfiled.dart';
import 'package:assets/screens/contact/contact_screen.dart';
import 'package:assets/utils/extensions/project_extensions.dart';
import 'package:assets/utils/styles/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({
    super.key,
    required this.onChanged,
  });

  // final VoidCallback onChanged;
  final Function onChanged;

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {



  @override
  Widget build(BuildContext context) {
    String phoneNumber = "";
    String firstName = "";
    String lastName = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        title: Text(
          "Add Contact",
          style: AppTextStyle.bodoniBold.copyWith(fontSize: 32),
        ),
        actions: [
          IconButton(
            onPressed: () {
              int id = contacts.isNotEmpty ? contacts.last.id +1: 0;
              print("id:${contacts.last.id}");
              ContactModel newContact = ContactModel(
                  lastName: lastName == "" ? "":lastName,
                  firstName: firstName,
                  phoneNumber: phoneNumber,
                  id: id
              );
              debugPrint("newContact:$newContact");
              if (newContact.firstName.isEmpty ||
                  newContact.phoneNumber.isEmpty ||  (newContact.phoneNumber.length <9) ? true :false  ) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content:
                        Text("User malumotlarini kiritishda hatoliklar bor?"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Kontact Saqlandi ?"),
                  ),
                );
                contacts.add(newContact);
                widget.onChanged.call();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context)=> const ContactScreen()),
                        (route) => false);
              }
            },
            icon: const Icon(Icons.done),
            color: Colors.green,
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w(), vertical: 15.h()),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.getH(),
              UniversalTextField(
                  hintText: "Enter Name",
                  onChanged: (valueName) {
                    firstName = valueName;
                  },
                  onSubmit: (v) {
                    firstName = v;
                  },
                  title: "Name"),
              20.getH(),
              UniversalTextField(
                  hintText: "Enter SurName",
                  onChanged: (valueName) {
                    lastName = valueName;
                  },
                  onSubmit: (v) {
                    lastName = v;
                  },
                  title: "SurName"),
              20.getH(),
              UniversalTextField(
                hintText: "_ _  _ _ _  _ _  _ _",
                onChanged: (valueName) {
                  phoneNumber = "+998$valueName";
                },
                onSubmit: (v) {
                  phoneNumber = "+998$v";
                },
                title: "Phone.",
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
