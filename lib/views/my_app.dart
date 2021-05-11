import 'package:contatos_app/repositories/contato.repository.dart';
import 'package:contatos_app/views/cadastro.view.dart';
import 'package:contatos_app/views/lista.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContatoRepository(),
      child: MaterialApp(
        routes: {
          '/': (context) => ListaView(),
          '/cadastro': (context) => CadastroView(),
        },
        initialRoute: '/',
      ),
    );
  }
}
