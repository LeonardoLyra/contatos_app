import 'dart:convert';
import 'dart:html';

import 'package:contatos_app/models/contato.model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ContatoRepository extends ChangeNotifier {
  final String url = 'https://lyra-contatos-api.herokuapp.com';
  //final String url = 'https://dezani-contatos-api.herokuapp.com';

  List<Contato> contatos = new List<Contato>();

  ContatoRepository() {
    read();
  }

  Future<bool> create(Contato contato) async {
    var response = await http.post(
      url,
      body: jsonEncode(contato.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Contato contato = Contato.fromJson(jsonDecode(response.body));
      this.contatos.add(contato);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> read() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable contatos = jsonDecode(response.body) as List;
      var lista = contatos.map((objeto) => Contato.fromJson(objeto));
      this.contatos = lista.toList();
      notifyListeners();
    }
  }

  Future<void> delete(int id) async {
    var response = await http.delete("$url/$id");
    if (response.statusCode == 200) {
      this.contatos.removeWhere((contato) => contato.id == id);
      notifyListeners();
    }
  }

  Future<void> update(Contato contato) async {
    var response = await http.put("$url/${contato.id}",
        body: jsonEncode(contato.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      int index = this.contatos.indexWhere((c) => c.id == contato.id);
      this.contatos[index] = contato;
      notifyListeners();
    }
  }
}
