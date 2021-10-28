class PersonNameInfo {
  String? familyName; //fn
  String? givenName; //gn
  String? familyNameT; //fnt
  String? givenNameT; //gnt

  PersonNameInfo({
    this.familyName,
    this.givenName,
    this.familyNameT,
    this.givenNameT,
  });

  factory PersonNameInfo.fromMap(Map names) {
    return PersonNameInfo(
      familyName: names["fn"],
      givenName: names["gn"],
      familyNameT: names["fnt"],
      givenNameT: names["gnt"],
    );
  }

  factory PersonNameInfo.defaultValues() {
    return PersonNameInfo();
  }
}
