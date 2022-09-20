import '../models/whats_app_user_model.dart';
import 'contacts.dart';

/// WhatsApp users in contacts
final List<WhatsAppUser> whatsappUsers = ([...contacts]..shuffle())
    .sublist(0, 25)
    .map((c) => WhatsAppUser.fromContact(c))
    .toList()
  ..sort((a, b) => a.name.compareTo(b.name));
