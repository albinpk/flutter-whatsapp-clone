import '../models/whats_app_user_model.dart';
import 'contacts.dart';

final List<WhatsAppUser> whatsappUsers = () {
  final contactsSubList = contacts..shuffle();
  final whatsappUsers = contactsSubList
      .sublist(0, 25)
      .map((c) => WhatsAppUser.fromContact(c))
      .toList();
  return whatsappUsers;
}();
