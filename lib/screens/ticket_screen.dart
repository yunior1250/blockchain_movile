import 'package:blckchain_movile/models/ticket.dart';
import 'package:blckchain_movile/services/evento_service.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage(
      {super.key,
      required this.idEvento,
      required this.idUser,
      required this.eventoService});

  final String idEvento;
  final String idUser;
  final EventoService eventoService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Detalles del Evento"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<Ticket>>(
            future: eventoService.getTiket(idUser, idEvento),
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
                    final Ticket item = snapshot.data![index];

                    Color ticketColor = Colors.blue; // Color por defecto

                    if (item.tipo == "oro") {
                      ticketColor = Colors.orange;
                    } else if (item.tipo == "plata") {
                      ticketColor = Colors.grey;
                    } else if (item.tipo == "bronce") {
                      ticketColor = const Color.fromARGB(255, 204, 98, 60);
                    }

                    return TicketWidget(
                      color: ticketColor,
                      width: 350,
                      height: 500,
                      isCornerRounded: true,
                      padding: const EdgeInsets.all(20),
                      child: TicketData(
                        precio: item.precio.toString(),
                        tipo: item.tipo,
                      ),
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
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({super.key, required this.precio, required this.tipo});
  final String precio;
  final String tipo;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120.0,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 1.0, color: Colors.red),
              ),
              child: Center(
                child: Text(
                  tipo,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            const Row(
              children: [
                Text(
                  'LHR',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.monetization_on,
                    color: Colors.pink,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'ISL',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Nombre del evento',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ticketDetailsWidget('Precio', '$precio bs', 'Date', '28-08-2022'),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 52.0),
              child: ticketDetailsWidget('Flight', '76836A45', 'Gate', '66B'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 53.0),
              child: ticketDetailsWidget('Class', 'Business', 'Seat', '21B'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
          child: Container(
            width: 250.0,
            height: 60.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/barra.png'), fit: BoxFit.cover)),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 75.0, right: 75.0),
          child: Text(
            '0000 +9230 2884 5163',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text('         Developer: instagram.com/tickst_so')
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
