class PushNotification {
  // onMessage: {
  //   notification: {
  //     title: Titulo 3 teste,
  //     body: Mensagem de teste distrito app
  //     },
  //   data: {
  //     key: value,
  //     canal: comunicacao
  //   }
  // }
  String title;
  String body;

  PushNotification({this.title, this.body});

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    return new PushNotification(
        title: json['notification']['title'],
        body: json['notification']['body']);
  }
}
