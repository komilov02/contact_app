class ContactModel {
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final int id;

  ContactModel({
    required this.lastName,
    required this.firstName,
    required this.phoneNumber,
    required this.id
  });

  @override
  String toString() {
    return '''
    Firstname:$firstName,
    LastName:$lastName,
    PhoneNumber:$phoneNumber,
''';
  }
}
