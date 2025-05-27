import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TriagemPage extends StatefulWidget {
  @override
  _TriagemPageState createState() => _TriagemPageState();
}

class _TriagemPageState extends State<TriagemPage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, String>? resultado;

  Future<void> enviarParaIA(String texto) async {
    final url = Uri.parse("http://192.168.100.177:5000/triagem"); // use o IP local do seu PC

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"descricao": texto}), // nome correto da chave
      );

      if (response.statusCode == 200) {
        final jsonFinal = jsonDecode(response.body);

        setState(() {
          resultado = {
            "area_do_direito": jsonFinal["área"] ?? "N/A",
            "gravidade": jsonFinal["prioridade"] ?? "N/A",
            "resumo": jsonFinal["resumo"] ?? "N/A",
            "resposta_breve": jsonFinal["necessidade_de_advogado"] ?? "N/A",
          };
        });
      } else {
        print("Erro na resposta: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao conectar com o backend: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Triagem Jurídica Simulada'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Descreva seu problema jurídico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final texto = _controller.text;
                enviarParaIA(texto);
              },
              child: Text('Analisar'),
            ),
            if (resultado != null)
              Card(
                margin: EdgeInsets.only(top: 24),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Área do Direito: ${resultado!["area_do_direito"]}', style: TextStyle(fontSize: 16)),
                      Text('Gravidade: ${resultado!["gravidade"]}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 12),
                      Text('Resumo:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${resultado!["resumo"]}'),
                      SizedBox(height: 12),
                      Text('Resposta breve:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${resultado!["resposta_breve"]}'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


