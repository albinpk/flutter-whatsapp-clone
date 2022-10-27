import 'whats_app_user_model.dart';

/// The user who use this app.
/// Just extends [WhatsAppUser]
class User extends WhatsAppUser {
  const User({
    required super.id,
    required super.name,
    required super.phNumber,
    super.dpUrl,
    super.about,
  });
}
