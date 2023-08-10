import 'package:blckchain_movile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EventoService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  List<Evento> eventos = [];
  List<Ticket> tickets = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /*  EmergencyService() {
    getEmergencies();
  } */
  Future<List<Evento>> getEventoByUserId(String id) async {
    /*   _isLoading = true;
    notifyListeners(); */
    try {
      final url = '$_baseUrl/api/eventos/$id';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<Evento> eventoTemp = Evento.parseEventoList(response.body);
        eventos = eventoTemp;
        return eventoTemp;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error en cargar los datos de evento');
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir
      print('Error al realizar la solicitud: $e');
      throw Exception('Error en cargar los datos de evento');
    } finally {
      /*  _isLoading = false;
      notifyListeners(); */
    }
  }

  Future<List<Ticket>> getTiket(String userId, String eventoId) async {
    /*   _isLoading = true;
    notifyListeners(); */
    try {
      final url = '$_baseUrl/api/tickets/$userId/$eventoId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<Ticket> ticketTemp = Ticket.parseTicketList(response.body);
        tickets = ticketTemp;
        return ticketTemp;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error en cargar los datos de ticket');
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir
      print('Error al realizar la solicitud: $e');
      throw Exception('Error en cargar los datos de ticket');
    } finally {
      /*  _isLoading = false;
      notifyListeners(); */
    }
  }
}
