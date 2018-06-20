String dataPorExtenso(num timestamp) {
  var data = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  return "${data.day.toString()} de ${_nomeMeses(data.month)} de ${data.year.toString()}";
}

String dataPorExtensoAbreviada(num timestamp) {
  var data = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  return "${data.day.toString()} ${_nomeMesesAbreviado(data.month)} ${data.year.toString()}";
}

_nomeMeses(num m) {
  switch (m) {
    case 1:
      return 'janeiro';
      break;
    case 2:
      return 'fevereiro';
      break;
    case 3:
      return 'março';
      break;
    case 4:
      return 'abril';
      break;
    case 5:
      return 'maio';
      break;
    case 6:
      return 'junho';
      break;
    case 7:
      return 'julho';
      break;
    case 8:
      return 'agosto';
      break;
    case 9:
      return 'setembro';
      break;
    case 10:
      return 'outubro';
      break;
    case 11:
      return 'novembro';
      break;
    case 12:
      return 'dezembro';
      break;
  }
}

_nomeMesesAbreviado(num m) {
  switch (m) {
    case 1:
      return 'Jan';
      break;
    case 2:
      return 'Fev';
      break;
    case 3:
      return 'Mar';
      break;
    case 4:
      return 'Abr';
      break;
    case 5:
      return 'Mai';
      break;
    case 6:
      return 'Jun';
      break;
    case 7:
      return 'Jul';
      break;
    case 8:
      return 'Ago';
      break;
    case 9:
      return 'Set';
      break;
    case 10:
      return 'Out';
      break;
    case 11:
      return 'Nov';
      break;
    case 12:
      return 'Dez';
      break;
  }
}
