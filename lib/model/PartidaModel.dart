enum Status { ABERTO, ANDAMENTO, FECHADO }

class Partidamodel {
  String id;
  String timeA;
  String timeB;
  String dataHora;
  String placarA;
  String placarB;
  Status status;

  Partidamodel({
    required this.id,
    required this.timeA,
    required this.timeB,
    required this.dataHora,
    required this.placarA,
    required this.placarB,
    required this.status,
  });
}
