// lib/global_data.dart

class LeadSimulado {
  final String id; // Poderia ser um timestamp ou UUID
  final String nomeUsuario; // Nome do usuário que enviou
  final String emailUsuario; // Email para "contato"
  final String telefoneUsuario; // Telefone para "contato"
  final String duvidaOriginal; // A descrição que o usuário enviou
  final String analiseIA; // A resposta que o Ollama deu
  // final String areaSimulada; // Se você ainda quiser usar a área simulada do backend
  // final List<String> tagsSimuladas; // Se você ainda quiser usar as tags simuladas
  String status; // Ex: "novo", "aceito_pelo_adv_X", "recusado_pelo_adv_X"

  LeadSimulado({
    required this.id,
    required this.nomeUsuario,
    required this.emailUsuario,
    required this.telefoneUsuario,
    required this.duvidaOriginal,
    required this.analiseIA,
    // required this.areaSimulada,
    // required this.tagsSimuladas,
    this.status = "novo",
  });
}

// Lista global para armazenar os leads simulados
// Esta lista será acessada e modificada por diferentes telas.
// Em um app real, isso seria gerenciado por um sistema de gerenciamento de estado
// (Provider, Riverpod, BLoC) e sincronizado com um backend/banco de dados.
List<LeadSimulado> leadsGlobaisSimulados = [];
