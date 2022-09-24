import '../../../../../core/models/models.dart';
import '../../../chat.dart';

class RecentChat {
  final WhatsAppUser user;
  final Message lastMessage;

  RecentChat({
    required this.user,
    required this.lastMessage,
  });
}
