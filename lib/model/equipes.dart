class Equipes {
  List<String> anciaos;
  List<String> diaconos;
  List<String> diaconisas;
  List<String> musica;
  List<String> recepcao;
  List<String> sonoplastia;

  Equipes(
      {this.anciaos,
      this.diaconos,
      this.diaconisas,
      this.musica,
      this.recepcao,
      this.sonoplastia});

  factory Equipes.fromJson(Map<dynamic, dynamic> json) {
    var anciaosFromJson = json['anciaos'];
    var diaconosFromJson = json['diaconos'];
    var diaconisasFromJson = json['diaconisas'];
    var musicaFromJson = json['musica'];
    var recepcaoFromJson = json['recepcao'];
    var sonoplastiaFromJson = json['sonoplastia'];
    List<String> anciaosList = anciaosFromJson.cast<String>();
    List<String> diaconosList = diaconosFromJson.cast<String>();
    List<String> diaconisasList = diaconisasFromJson.cast<String>();
    List<String> musicaList = musicaFromJson.cast<String>();
    List<String> recepcaoList = recepcaoFromJson.cast<String>();
    List<String> sonoplastiaList = sonoplastiaFromJson.cast<String>();

    Equipes equipes = new Equipes(
        anciaos: anciaosList,
        diaconos: diaconosList,
        diaconisas: diaconisasList,
        musica: musicaList,
        recepcao: recepcaoList,
        sonoplastia: sonoplastiaList);
    Map<String, List<String>> equipesMap = json.cast<String, List<String>>();
  }
}
