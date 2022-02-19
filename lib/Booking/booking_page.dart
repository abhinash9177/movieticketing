import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_ticket_booking/Booking/mybookings.dart';
import 'package:movie_ticket_booking/Booking/repo.dart';
import 'package:movie_ticket_booking/const/const.dart';
import 'package:movie_ticket_booking/forms/login.dart';
import 'package:movie_ticket_booking/homepage.dart';
import 'package:path_provider/path_provider.dart';

class BookTicketsPage extends StatefulWidget {
  const BookTicketsPage({Key? key}) : super(key: key);

  @override
  _BookTicketsPageState createState() => _BookTicketsPageState();
}

class _BookTicketsPageState extends State<BookTicketsPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();

  String? dropdownError;
  String? dropdownmovieserror;
  int numberoftickets = 0;
  int? price = 0;
  String? selectmovie;

  bool dropdownfield = false;

  _validatedropdown() {
    bool _isValid = _BookTicketsPagekey.currentState!.validate();

    if (selectmovie == null) {
      setState(() => dropdownmovieserror = "Please select a movie");
      _isValid = false;
    }

    if (_isValid) {
      setState(() {
        dropdownfield = true;
      });
    }
  }

//location
  Repository repo = Repository();
  List savedata = [];
  late Box box;
  List<String> movie = ["SELECT MOVIE"];

  @override
  void initState() {
    movie = List.from(repo.movielist);
    Hive.initFlutter();
    super.initState();
  }
  //drop down

  //form fields
  final _BookTicketsPagekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.cyan[300],
        title: const Text('Book Tickets'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyBookings()));
              },
              child: const Text(
                'MyBookings',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: background(),
            child: Form(
              key: _BookTicketsPagekey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Text(
                    'Book Your Tickets.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 75,
                                child: Mytextfield(
                                    namecontoller: namecontroller,
                                    hint: 'Enter',
                                    label: 'Enter Your Name.',
                                    keyboard: 'TEXT'),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 75,
                                child: Mytextfield(
                                    namecontoller: phonenumbercontroller,
                                    hint: 'Enter',
                                    label: 'Enter Mobile No.',
                                    keyboard: 'NUMBER'),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.cyan[200],
                                  border: Border.all(color: Colors.black12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 60,
                                child: DropdownButton<String>(
                                  hint: const Text('SELECT MOVIE'),
                                  value: selectmovie,
                                  isExpanded: true,
                                  items: movie.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (movies) {
                                    setState(() {
                                      selectmovie = movies;
                                      dropdownError = null;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                child: dropdownmovieserror == null
                                    ? const SizedBox.shrink()
                                    : Text(
                                        dropdownmovieserror ?? "",
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 14),
                                      ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                height: 75,
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Number of tickets'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (numberoftickets > 0) {
                                                  setState(() {
                                                    numberoftickets--;
                                                  });
                                                  amount();
                                                }
                                              },
                                              icon: const Icon(Icons.remove)),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            child: Text(
                                                numberoftickets.toString()),
                                          ),
                                          const SizedBox(width: 5),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  numberoftickets++;
                                                });
                                                amount();
                                              },
                                              icon: const Icon(Icons.add)),
                                          const SizedBox(width: 15),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text('Amount to be paid: Rs. $price'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(width: 150, child: button('Submit', _submit)),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    _validatedropdown();
    print(selectmovie);

    if (_BookTicketsPagekey.currentState!.validate() && dropdownfield == true) {
      if (numberoftickets > 6) {
        final overticket = SnackBar(
          content: const Text('You can book upto 6 tickets only!'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              Navigator.of(context);
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(overticket);
      }
      if (numberoftickets == 0) {
        final lesstickets = SnackBar(
          content: const Text('Please select atleast 1 ticket!'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              Navigator.of(context);
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(lesstickets);
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            height: 300,
            child: AlertDialog(
              title: const Text('Ticket Confirmation'),
              content: Table(
                border: TableBorder.all(width: 1.0),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    const SizedBox(
                        height: 50, child: Center(child: Text('name'))),
                    Center(child: Text(namecontroller.text)),
                  ]),
                  TableRow(children: [
                    const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('Mobile'),
                        )),
                    Center(
                      child: Text(phonenumbercontroller.text),
                    ),
                  ]),
                  TableRow(children: [
                    const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('Movie'),
                        )),
                    Center(
                      child: Text(selectmovie!),
                    ),
                  ]),
                  TableRow(children: [
                    const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('Tickets'),
                        )),
                    Center(
                      child: Text(numberoftickets.toString()),
                    ),
                  ]),
                  TableRow(children: [
                    const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('Amount'),
                        )),
                    Center(
                      child: Text(price.toString()),
                    ),
                  ])
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await openBox();
                    setState(() {
                      savedata = [
                        {
                          'name': namecontroller.text,
                          'mobile': phonenumbercontroller.text,
                          'movie': selectmovie,
                          'tickets': numberoftickets,
                          'amount': price
                        }
                      ];
                    });
                    await putData(savedata).then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyBookings())));
                    namecontroller.clear();
                    phonenumbercontroller.clear();
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  amount() {
    setState(() {
      price = numberoftickets * 250;
    });
  }

  Future openBox() async {
    var local = await getApplicationDocumentsDirectory();
    Hive.init(local.path);
    box = await Hive.openBox('mydata');
    return;
  }

  Future putData(savedata) async {
    for (var d in savedata) {
      box.add(d);
    }
  }
}
