class DevDetails {
  final String address;
  final String email;
  final String policylink;
  final String website;

  DevDetails(
      {required this.website,
      required this.address,
      required this.email,
      required this.policylink});

  static DevDetails toMap(Map<String, dynamic>? data) {
    return DevDetails(
      address: data!['address'],
      website: data['website'],
      email: data['email'],
      policylink: data['policy_link'],
    );
  }
}
