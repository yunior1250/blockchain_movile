import 'dart:convert';

class Ticket {
  Ticket({
    this.id,
    required this.precio,
    required this.tipo,
    required this.restricciones,
    required this.instrucciones,
    required this.eventoId,
    required this.userId,
    this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String precio;
  String tipo;
  String restricciones;
  String instrucciones;
  int eventoId;
  int userId;
  dynamic createdAt;
  String updatedAt;

  factory Ticket.fromJson(String str) => Ticket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        precio: json["precio"],
        tipo: json["tipo"],
        restricciones: json["restricciones"],
        instrucciones: json["instrucciones"],
        eventoId: json["evento_id"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "precio": precio,
        "tipo": tipo,
        "restricciones": restricciones,
        "instrucciones": instrucciones,
        "evento_id": eventoId,
        "user_id": userId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  static List<Ticket> parseTicketList(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final Map<String, dynamic>? ticketJson = parsedJson['ticket'];
    if (ticketJson != null) {
      return [Ticket.fromMap(ticketJson)];
    } else {
      return [];
    }
  }
}
