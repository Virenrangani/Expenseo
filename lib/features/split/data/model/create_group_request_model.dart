class CreateGroupRequest {
  final String name;
  final List<String> memberEmails;

  const CreateGroupRequest({
    required this.name,
    required this.memberEmails,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberEmails': memberEmails,
    };
  }
}