import 'package:contatos_app/models/contato.model.dart';
import 'package:contatos_app/repositories/contato.repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroView extends StatelessWidget {
  Contato contato = new Contato();
  var _formKey = GlobalKey<FormState>();

  Future<void> salvar(
      BuildContext context, ContatoRepository repository) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (await repository.create(contato)) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Falha no cadastro"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var repository = Provider.of<ContatoRepository>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo Contato"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nome",
                    ),
                    validator: (value) =>
                        value.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (value) => contato.nome = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Telefone",
                    ),
                    validator: (value) =>
                        value.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (value) => contato.telefone = value,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Salvar"),
                        onPressed: () => salvar(context, repository),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
