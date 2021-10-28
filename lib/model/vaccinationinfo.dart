class VaccinationInfo {
  String? ci; //ci
  String? co; //co
  String? dn; //dn
  String? dt; //dt
  String? certificateIssuer; //is
  String? ma; //ma
  String? mp; //mp
  String? sd; //sd
  String? tg; //tg
  String? vp; //vp

  VaccinationInfo({
    this.ci,
    this.co,
    this.dn,
    this.dt,
    this.certificateIssuer,
    this.ma,
    this.mp,
    this.sd,
    this.tg,
    this.vp,
  });

  factory VaccinationInfo.fromMap(Map v) {
    return VaccinationInfo(
      ci: v["ci"].toString(),
      co: v["co"].toString(),
      dn: v["dn"].toString(),
      dt: v["dt"].toString(),
      certificateIssuer: v["is"].toString(),
      ma: v["ma"].toString(),
      mp: v["mp"].toString(),
      sd: v["sd"].toString(),
      tg: v["tg"].toString(),
      vp: v["vp"].toString(),
    );
  }

  factory VaccinationInfo.defaultValues() {
    return VaccinationInfo();
  }
}
