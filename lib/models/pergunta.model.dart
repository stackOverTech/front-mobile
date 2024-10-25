class Pergunta {
  final int id;
  final int idUsuario;
  final int idDisciplina;
  final int idInstituicao;
  final String enunciado;
  final String? imagem;
  final String? imagemPessoa;
  final String? codigo;
  final String usuario;
  final String disciplinas;
  final DateTime dataCriacao;
  final int tempoDesdeCriacao;

  Pergunta({
    required this.id,
    required this.idUsuario,
    required this.idDisciplina,
    required this.idInstituicao,
    required this.enunciado,
    required this.imagemPessoa,
    this.imagem,
    this.codigo,
    required this.dataCriacao,
    required this.usuario,
    required this.disciplinas,
    required this.tempoDesdeCriacao,
  });

  factory Pergunta.fromJson(Map<String, dynamic> json) {
    return Pergunta(
        id: json['id'],
        idUsuario: json['id_usuario'],
        idDisciplina: json['id_disciplina'],
        idInstituicao: json['id_instituicao'],
        enunciado: json['enunciado'],
        imagem: json['imagem'],
        codigo: json['codigo'],
        dataCriacao: DateTime.parse(json['data_criacao']),
        usuario: json['usuario']['nome'],
        disciplinas: json['disciplinas']['nome'],
        tempoDesdeCriacao: json['tempoDesdeCriacao'],
        imagemPessoa: json['usuario']['foto']);
  }
}
