import 'package:blckchain_movile/models/models.dart';
import 'package:blckchain_movile/screens/ticket_screen.dart';
import 'package:blckchain_movile/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blckchain_movile/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final String? idUser;

  const HomeScreen({Key? key, this.idUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.user;
    final eventoService = context.read<EventoService>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("ClipTicket"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Eventos",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<Evento>>(
                future: eventoService
                    .getEventoByUserId(idUser ?? user!.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error al cargar los datos'),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final Evento item = snapshot.data![index];
                        return EventWidgetStatic(
                          idEvento: item.id.toString(),
                          idUser: idUser ?? user!.id.toString(),
                          nombre: item.nombre,
                          direccion: item.direccion,
                          fecha: item.fecha,
                          hora: item.hora,
                          eventoService: eventoService,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No se encontraron eventos.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventWidgetStatic extends StatelessWidget {
  const EventWidgetStatic(
      {super.key,
      required this.nombre,
      required this.direccion,
      required this.fecha,
      required this.hora,
      required this.idEvento,
      required this.idUser,
      required this.eventoService});

  final String nombre;
  final String direccion;
  final String fecha;
  final String hora;

  final String idEvento;
  final String idUser;

  final EventoService eventoService;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetailsPage(
                      idEvento: idEvento,
                      idUser: idUser,
                      eventoService: eventoService,
                    ))); // Reemplaza EventDetailsPage con la página a la que deseas redireccionar
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        elevation: 4,
        color: Colors.redAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/evento.jpeg', // Reemplaza con la ruta de tu imagen
                  height: 150,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            nombre,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(Icons.location_on),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                direccion,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '$fecha $hora',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
