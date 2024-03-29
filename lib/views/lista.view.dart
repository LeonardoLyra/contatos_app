import 'package:contatos_app/models/contato.model.dart';
import 'package:contatos_app/repositories/contato.repository.dart';
import 'package:contatos_app/views/cadastro.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
      ),
      body: Consumer<ContatoRepository>(builder: (context, repository, child) {
        var contatos = repository.contatos;
        return ListView.builder(
          itemCount: contatos.length,
          itemBuilder: (_, index) {
            Contato contato = contatos[index];
            return ListTile(
              title: Text(contato.nome),
              subtitle: Text(contato.telefone),
              trailing: Container(
                width: 96,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: () => repository.delete(contato.id),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                      ),
                      onPressed: () => Navigator.of(context)
                          .pushNamed("/cadastro", arguments: repository),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/cadastro'),
      ),
    );
  }
}
