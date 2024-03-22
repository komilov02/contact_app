import 'package:contact/models/contact_model.dart';
import 'package:contact/models/repository.dart';
import 'package:contact/screens/add_contact/widgets/universal_textfiled.dart';
import 'package:contact/screens/contact/contact_screen.dart';
import 'package:contact/screens/widgets/global_app_bar.dart';
import 'package:contact/utils/colors/app_colors.dart';
import 'package:contact/utils/extensions/project_extensions.dart';
import 'package:contact/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({
    super.key,
    required this.clickedContactIndex,
  });

  final int clickedContactIndex;

  // final Function onChanged;
  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  late ContactModel contactModel;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    contactModel = contacts[widget.clickedContactIndex];
    _firstNameController.text = contactModel.firstName;
    _lastNameController.text = contactModel.lastName;

    if (contactModel.phoneNumber.length > 9) {
      String slicedPhoneNumber = contactModel.phoneNumber.substring(4);
      _phoneController.text = slicedPhoneNumber;
    } else {
      _phoneController.text = contactModel.phoneNumber;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String firstName = contactModel.firstName;
    String lastName = contactModel.lastName;
    String phoneNumber;
    if (contactModel.phoneNumber.length > 9) {
      phoneNumber = contactModel.phoneNumber.substring(4);
    } else {
      phoneNumber = contactModel.phoneNumber;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactScreen(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        title: Text(
          "Contacts",
          style: AppTextStyle.interSemiBold.copyWith(
            fontSize: 20,
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          52.getH(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: Icon(
                  Icons.account_circle,
                  size: 100.h(),
                  color: Colors.grey,
                ),
              ),

              // Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            icon: const Icon(
                              Icons.warning_amber,
                              size: 32,
                            ),
                            iconColor: Colors.red,
                            title: const Text("Ogohlantirish"),
                            content:
                                const Text("Siz bu contactni ochirmoqchimisz?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  contacts.removeAt(widget.clickedContactIndex);
                                  setState(() {});
                                  // Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        " ${contactModel.firstName + contactModel.lastName} o'chirildi  "),
                                    duration: const Duration(seconds: 2),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ContactScreen()));
                                },
                                child: const Text("Ok"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Material(
                            color: Colors.black38,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.1467),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 40),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Text(
                                      " Contactni ozgartirish",
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                    30.getH(),
                                    UniversalTextField(
                                      hintText: "Enter new Name",
                                      onChanged: (valueName) {
                                        firstName = valueName;
                                      },
                                      onSubmit: (v) {
                                        firstName = v;
                                      },
                                      title: "Name",
                                      inputController: _firstNameController,
                                    ),
                                    20.getH(),
                                    UniversalTextField(
                                      hintText: "Enter new SurName",
                                      onChanged: (valueName) {
                                        lastName = valueName;
                                      },
                                      onSubmit: (v) {
                                        lastName = v;
                                      },
                                      title: "SurName",
                                      inputController: _lastNameController,
                                    ),
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
                                      inputController: _phoneController,
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              ContactModel newContact =
                                                  ContactModel(
                                                      lastName: lastName == ""
                                                          ? ""
                                                          : lastName,
                                                      firstName: firstName,
                                                      phoneNumber:
                                                          "+998$phoneNumber",
                                                      id: widget
                                                          .clickedContactIndex);

                                              if (newContact
                                                      .firstName.isEmpty ||
                                                  newContact
                                                      .phoneNumber.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    content: Text(
                                                        "User malumotlarini kiritishda hatoliklar bor?"),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                        "Contact O'zgartirildi ?"),
                                                  ),
                                                );
                                                contacts[widget
                                                        .clickedContactIndex] =
                                                    newContact;


                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ContactInfoScreen(
                                                      clickedContactIndex: widget
                                                          .clickedContactIndex,
                                                    ),
                                                  ),
                                                  (route) => false,
                                                );
                                              }
                                            },
                                            child: const Text("Ok"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No"),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.edit)),
              8.getW()
            ],
          ),
          20.getH(),
          Text(
            "${contactModel.firstName} ${contactModel.lastName}",
            style: AppTextStyle.bodoniBold.copyWith(fontSize: 22),
          ),
          40.getH(),
          Row(
            children: [
              15.getW(),
              Text(
                contactModel.phoneNumber,
                style: AppTextStyle.bodoniBold.copyWith(fontSize: 16),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  Uri uri = Uri.parse("tel:${contactModel.phoneNumber}");
                  launchUrl(uri);
                },
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
              15.getW(),
              FloatingActionButton(
                onPressed: () {
                  String uri =
                      'sms:${contactModel.phoneNumber}?body=${Uri.encodeComponent("Hello ${contactModel.firstName}")}';
                  launchUrl(Uri.parse(uri));
                },
                backgroundColor: Colors.orange,
                child: const Icon(
                  Icons.message,
                  color: Colors.white,
                ),
              ),
              15.getW(),
            ],
          )
        ],
      ),
    );
  }
}
