class Contato {
  int id;
  String nome;
  String telefone;

  Contato({this.id, this.nome, this.telefone});

  Contato.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "nome": nome, "telefone": telefone};
  }
}

// Contato c = Contato.fromJson(json);
//
// c.toJson()
