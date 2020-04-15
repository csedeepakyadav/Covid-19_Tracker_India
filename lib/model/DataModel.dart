class CovidData {
//  String city;

  String country;
  String lastUpdate;
  String keyId;
  int confirmed;
  int deaths;
  int recovered;

  CovidData(
      {
    //    this.city,
   
      this.country,
      this.lastUpdate,
      this.keyId,
      this.confirmed,
      this.deaths,
      this.recovered});

  CovidData.fromJson(Map<String, dynamic> json) {
  //  city = json['city'];

    country = json['country'];
    lastUpdate = json['lastUpdate'];
    keyId = json['keyId'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  //  data['city'] = this.city;
    data['country'] = this.country;
    data['lastUpdate'] = this.lastUpdate;
    data['keyId'] = this.keyId;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}