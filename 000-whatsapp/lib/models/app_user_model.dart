import 'whats_app_user_model.dart';

/// The user who use this app.
/// Just extends [WhatsAppUser]
class AppUser extends WhatsAppUser {
  const AppUser({
    required super.id,
    required super.name,
    required super.phNumber,
    super.friends,
    super.about,
  });
}
