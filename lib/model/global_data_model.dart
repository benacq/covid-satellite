class CovidGlobalModel {
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
  int affectedCountries;

  CovidGlobalModel(
      {this.updated,
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
      this.population,
      this.activePerOneMillion,
      this.recoveredPerOneMillion,
      this.criticalPerOneMillion,
      this.affectedCountries});

  factory CovidGlobalModel.fromJson(Map<String, dynamic> json) {
    // json.forEach((key, value) {
    //   print("$key : $value");
    // });

    return CovidGlobalModel(
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
      population: json['population'],
      activePerOneMillion: json['activePerOneMillion'],
      recoveredPerOneMillion: json['recoveredPerOneMillion'],
      criticalPerOneMillion: json['criticalPerOneMillion'],
      affectedCountries: json['affectedCountries'],
    );
  }
}
