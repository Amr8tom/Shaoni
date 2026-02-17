class NotificationEntity {
  final int id;
  final String title;
  final String description;
  final bool isApproved;
  final bool isRead;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isApproved,
    required this.isRead,
  });
}
