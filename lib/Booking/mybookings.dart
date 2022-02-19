import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_ticket_booking/Booking/booking_page.dart';
import 'package:path_provider/path_provider.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  late Box box;
  bool bookings = false;
  List data = [];

  @override
  void initState() {
    super.initState();
    Hive.initFlutter();

    openBox();
  }

  Future openBox() async {
    var local = await getApplicationDocumentsDirectory();
    Hive.init(local.path);
    box = await Hive.openBox('mydata');
    mybookigs();
    return;
  }

  mybookigs() {
    var offlineData = box.toMap().values.toList();
    if (offlineData.isEmpty) {
      setState(() {
        bookings = true;
      });
    } else {
      setState(() {
        data = offlineData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookTicketsPage())),
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.cyan[300],
          title: const Text('My Bookings'),
          actions: [
            TextButton(
                onPressed: () {
                  box.clear().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookTicketsPage())));
                },
                child: const Text(
                  'Delete all',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: bookings
            ? const Center(
                child: SizedBox(
                child: Text('No Bookings'),
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text('Movie Name'),
                            Text('Tickets'),
                          ],
                        )),
                    Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        print(data.length.toString());
                        return GestureDetector(
                          onTap: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => SizedBox(
                                    height: 300,
                                    child: AlertDialog(
                                        title:
                                            const Text('Ticket Confirmation'),
                                        content: Table(
                                          border: TableBorder.all(width: 1.0),
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          children: [
                                            TableRow(children: [
                                              const SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                      child: Text('name'))),
                                              Center(
                                                  child: Text(
                                                      data[index]['name'])),
                                            ]),
                                            TableRow(children: [
                                              const SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                    child: Text('Mobile'),
                                                  )),
                                              Center(
                                                child:
                                                    Text(data[index]['mobile']),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              const SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                    child: Text('Movie'),
                                                  )),
                                              Center(
                                                child:
                                                    Text(data[index]['movie']),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              const SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                    child: Text('Tickets'),
                                                  )),
                                              Center(
                                                child: Text(data[index]
                                                        ['tickets']
                                                    .toString()),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              const SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                    child: Text('Amount'),
                                                  )),
                                              Center(
                                                child: Text(data[index]
                                                        ['amount']
                                                    .toString()),
                                              ),
                                            ])
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'Cancel');
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ])));
                          },
                          child: CustomCard(
                            movie: data[index]['movie'],
                            tickets: data[index]['tickets'],
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ));
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.movie, required this.tickets})
      : super(key: key);

  final String movie;
  final int tickets;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan[200],
      child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(movie),
              Text(tickets.toString()),
            ],
          )),
    );
  }
}
