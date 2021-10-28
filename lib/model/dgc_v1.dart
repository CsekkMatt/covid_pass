import 'nameinfo.dart';
import 'vaccinationinfo.dart';

class DgcV1 {
  VaccinationInfo? vaccinationInfo; //v
  PersonNameInfo? names; //nam
  String? version; //ver
  String? dateOfBirth; //dob

  DgcV1({
    this.vaccinationInfo,
    this.dateOfBirth,
    this.names,
    this.version,
  });

  factory DgcV1.fromMap(Map certificate) {
    return DgcV1(
        vaccinationInfo: VaccinationInfo.fromMap(certificate["v"][0]),
        dateOfBirth: certificate["dob"],
        names: PersonNameInfo.fromMap(certificate["nam"]),
        version: certificate["ver"]);
  }

  factory DgcV1.defaultValues() {
    return DgcV1();
  }
}
