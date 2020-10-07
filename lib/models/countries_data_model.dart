class CovidCountriesModel {
  String continent;
  String country;
  num lat;
  num long;
  String flag;
  int updated;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int todayRecovered;
  int active;
  int critical;
  num casesPerOneMillion;
  num deathsPerOneMillion;
  int tests;
  num testsPerOneMillion;
  int population;
  num activePerOneMillion;
  num recoveredPerOneMillion;
  num criticalPerOneMillion;

  CovidCountriesModel({
    this.country,
    this.flag,
    this.long,
    this.lat,
    this.continent,
    this.updated,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
  });

  factory CovidCountriesModel.fromJson(Map<String, dynamic> json) {
    return CovidCountriesModel(
      continent: json['continent'],
      country: json['country'],
      long: json['countryInfo']['long'],
      lat: json['countryInfo']['lat'],
      flag: json['countryInfo']['flag'],
      updated: json['updated'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      todayRecovered: json['todayRecovered'],
      active: json['active'],
      critical: json['critical'],
      casesPerOneMillion: json['casesPerOneMillion'],
      deathsPerOneMillion: json['deathsPerOneMillion'],
      tests: json['tests'],
      testsPerOneMillion: json['testsPerOneMillion'],
    );
  }
}
