import 'dart:convert';

class Evento {
  Evento({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.contacto,
    required this.fecha,
    required this.hora,
    required this.descripcion,
    required this.imagen,
    required this.organizadorId,
    required this.categoriaId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String nombre;
  String direccion;
  String contacto;
  String fecha;
  String hora;
  String descripcion;
  String imagen;
  int organizadorId;
  int categoriaId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Evento.fromJson(String str) => Evento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Evento.fromMap(Map<String, dynamic> json) => Evento(
        id: json["id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        contacto: json["contacto"],
        fecha: json["fecha"],
        hora: json["hora"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        organizadorId: json["organizadorId"],
        categoriaId: json["categoria_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "contacto": contacto,
        "fecha": fecha,
        "hora": hora,
        "descripcion": descripcion,
        "imagen": imagen,
        "organizadorId": organizadorId,
        "categoria_id": categoriaId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  static List<Evento> parseEventoList(String jsonString) {
    final parsedJson = json.decode(jsonString);
    final eventosListJson = parsedJson['eventos'] as List<dynamic>;
    return eventosListJson
        .map((evento) => Evento.fromMap(evento))
        .toList();
  }
}