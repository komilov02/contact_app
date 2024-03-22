import 'package:contact/models/contact_model.dart';
import 'package:contact/screens/add_contact/add_contact_screen.dart';
import 'package:contact/screens/contact/widgets/contact_item.dart';
import 'package:contact/screens/contact_info/contact_info_screen.dart';
import 'package:contact/screens/widgets/global_app_bar.dart';
import 'package:contact/utils/colors/app_colors.dart';
import 'package:contact/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:contact/models/repository.dart';
import 'package:contact/utils/extensions/project_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/repository.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({
    super.key,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ContactModel> _contactData = [];
  bool isActive = true;
  bool _isLoading = false;


  @override
  void initState() {
    _contactData = contacts;
    isActive = true;
    _searchController.addListener(_performSearch);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    //Simulates waiting for an API call
    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      _contactData = contacts
          .where(
              (element) =>
          element.firstName
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
              element.lastName
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase())

      )
          .toList();
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {

    print("contacts:$contacts");

    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(

      appBar: isActive ? GlobalAppBar(
        onMoreTap: () {},
        onSearchTap: () {
          isActive = false;
          setState(() {

          });
          print("SEARCH bosildi");
        }, backIsVisible: false,
      ) : AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,

          ),
          onChanged: (value) {
            print("Changed value $value");
            // contacts.where((element) => {
            //
            // } );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              isActive = true;
              setState(() {

              });
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.black,
            ),
          )
        ],
      ),
      body: contacts.isEmpty
          ? (_isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.black),
      ) :
      Center(child: SvgPicture.asset(AppImages.emptyBox)))
          : SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < _contactData.length; i++)
              ContactItem(
                onCallTap: () {
                  debugPrint("tel:${_contactData[i].phoneNumber}");
                  Uri uri = Uri.parse("tel:${_contactData[i].phoneNumber}");
                  launchUrl(uri);
                },
                onContactTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ContactInfoScreen(
                          clickedContactIndex: _contactData[i].id,

                        );
                      },
                    ),
                  );
                },
                contactModel: _contactData[i],
              ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (conctext) {
            return AddContactScreen(
              onChanged: () {
                setState(() {

                });
                debugPrint("Contact added");
              },
            );
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

