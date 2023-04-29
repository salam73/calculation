import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: "Tajawal",
        primaryColor: Colors.white,
        // iconTheme: IconThemeData(color: AppColors.primeColor),
      ),
      theme: ThemeData(
        fontFamily: "Tajawal",
        primaryColor: Colors.white,
        // iconTheme: IconThemeData(color: AppColors.primeColor),
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int amount = 0;
  int numberOfInstallment = 1;
  intl.DateFormat formatter = intl.DateFormat('dd-MM-yyyy');
  int i = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int periodAmount = (((amount / 1000) / numberOfInstallment).round() * 1000);
    int lastAmount = (amount) - (periodAmount * (numberOfInstallment - 1));
    DateTime currentDate = DateTime.now();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('نظام التقسيط'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'القيمه'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            amount = int.parse(value!);
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'عدد الاشهر'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => {
                          setState(() {
                            numberOfInstallment = int.parse(value!);
                          })
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        child: Text('احسب'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                /* Text(
                  'الاشهر ${numberOfInstallment - 1}',
                  style: TextStyle(fontSize: 30),
                ),*/
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (i = 0; i < numberOfInstallment - 1; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text('الدفعة -${i + 1}  ',
                                style: TextStyle(fontSize: 15)),
                          ),
                          SizedBox(
                            width: 120,
                            child: Text(
                                '${formatter.format(currentDate.add(Duration(days: 30 * i)))}',
                                style: TextStyle(fontSize: 15)),
                          ),
                          SizedBox(
                            width: 140,
                            child: Text('  ${periodAmount.toString()}',
                                style: TextStyle(fontSize: 15)),
                          )
                        ],
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        'الدفعه الاخيره: ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        '${formatter.format(currentDate.add(Duration(days: 30 * i)))}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: Text(
                        '$lastAmount',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
