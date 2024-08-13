import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

import 'package:plassma/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// void main() => runApp(MyApp());
class running_trainfrom extends StatelessWidget {
  const running_trainfrom({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum Options { option1, option2, option3, option4, option5, option6}

class _MyHomePageState extends State<MyHomePage> {
  bool _showFirstWidget = true;
  Options _selectedOption = Options.option1;
  void _toggleWidget() {
    setState(() {
      _showFirstWidget = !_showFirstWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              Image.asset("images/logo.jpg",
                  width: 30, height: 30, fit: BoxFit.fill),
              const Text(
                "Plama detection",
                style: TextStyle(
                    color: Color.fromARGB(255, 151, 88, 253),
                    fontFamily: 'Poppins',
                    fontSize: 15),
              ),
            ],
          ),
        ),
        // title: Text('Plama detection'),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            SideMenu(
              backgroundColor: const Color.fromARGB(255, 231, 231, 231),
              builder: (data) => SideMenuData(
                header: const Column(
                  children: [
                    SizedBox(
                      height: (30),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        // color: Color.fromARGB(255, 255, 37, 37),
                        // width: 100,
                        height: 30,
                        child: Center(
                          child: Text(
                            "  Menu",
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                items: [
                  SideMenuItemDataTile(
                    highlightSelectedColor:
                        const Color.fromARGB(255, 255, 255, 255),
                    hoverColor: const Color.fromARGB(255, 156, 156, 156),
                    isSelected: false,
                    onTap: () {
                      setState(() {
                        _selectedOption = Options.option1;
                      });
                    },
                    title: '   Running',
                    icon: const Icon(Icons.run_circle),
                    // icon: Image.asset("images/arrows.png")
                  ),
                  SideMenuItemDataTile(
                    highlightSelectedColor: Colors.white,
                    hoverColor: const Color.fromARGB(255, 156, 156, 156),
                    isSelected: false,
                    onTap: () {
                      setState(() {
                        _selectedOption = Options.option2;
                      });
                    },
                    title: '   Dashboard',
                    icon: const Icon(Icons.home),
                  ),
                  SideMenuItemDataTile(
                    highlightSelectedColor: Colors.white,
                    hoverColor: const Color.fromARGB(255, 156, 156, 156),
                    isSelected: false,
                    onTap: () {
                      setState(() {
                        _selectedOption = Options.option3;
                      });
                    },
                    title: '   Train',
                    icon: const Icon(Icons.settings),
                  ),
                  SideMenuItemDataTile(
                    highlightSelectedColor: Colors.white,
                    hoverColor: const Color.fromARGB(255, 156, 156, 156),
                    isSelected: false,
                    onTap: () {
                      setState(() {
                        _selectedOption = Options.option4;
                      });
                    },
                    title: '   Data Center',
                    icon: const Icon(Icons.dataset),
                  ),
                  SideMenuItemDataTile(
                    highlightSelectedColor: Colors.white,
                    hoverColor: const Color.fromARGB(255, 156, 156, 156),
                    isSelected: false,
                    onTap: () {
                      setState(() {
                        _selectedOption = Options.option5;
                      });
                    },
                    title: '   Data Center for train',
                    icon: const Icon(Icons.dataset),
                  ),
                  SideMenuItemDataTile(
                    highlightSelectedColor: Colors.white,
                    hoverColor: const Color.fromARGB(255, 156, 156, 156),
                    isSelected: false,
                    onTap: () {
                      setState(() {
                        _selectedOption = Options.option6;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Login()));
                      });
                    },
                    title: '   Logout',
                    icon: const Icon(Icons.exit_to_app),
                  ),
                ],
                // footer: const Text('Footer'),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      if (_selectedOption == Options.option1)
                        Running_Widget()
                      else if (_selectedOption == Options.option2)
                        Dashboard_Widget()
                      else if (_selectedOption == Options.option3)
                        const Train_Widget()
                      else if (_selectedOption == Options.option4)
                        DataCenter_Widget()
                      else if (_selectedOption == Options.option5)
                        DataCenter_for_train(), // Add a default case to handle other options
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Running_Widget extends StatefulWidget {
  Running_Widget({super.key});

  // bool initialBoolean;
  // Running_Widget({required this.initialBoolean});
  @override
  String global_version = "1.0.0";
  String global_mse = "0.001";
  String global_performance = "99";

  //disboard var
  bool st_swich_graph = false;

  @override
  State<Running_Widget> createState() => _Running_WidgetState();
}

class _Running_WidgetState extends State<Running_Widget> {
  // map keep histry------------

  // map keep histry------------

  // setting tube ------------------------------------------------------------------
  final tube_hight = TextEditingController();
  final tube_diameter = TextEditingController();
  final tube_px = TextEditingController();
  final tube_mm = TextEditingController();
  final tube_name_setting = TextEditingController();

  final name_setting_now = TextEditingController();

  @override
  Future<void> settingapp() async {
    final String tubeHightStr = tube_hight.text;
    final String tubeDiameterStr = tube_diameter.text;
    final String tubePxStr = tube_px.text;
    final String tubeMmStr = tube_mm.text;
    final String tubeNameSettingStr = tube_name_setting.text;

    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/setting'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'time_save': (DateTime.now().millisecondsSinceEpoch).toString(),
        'tube_name_setting_str': tubeNameSettingStr,
        'tube_hight_str': tubeHightStr,
        'tube_diameter_str': tubeDiameterStr,
        'tube_px_str': tubePxStr,
        'tube_mm_str': tubeMmStr,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Response data: ${responseData['st']}');
      if (responseData['stsave']) {
        use_now_setting();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text("Model version $version"),
              content: const SizedBox(
                height: 50,
                width: 200,
                child: Column(
                  children: [
                    Center(
                      child: Row(children: [
                        Icon(
                          Icons.report_problem,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "save Failed",
                          style: TextStyle(fontSize: 25),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("Model version $version"),
            content: const SizedBox(
              height: 50,
              width: 200,
              child: Column(
                children: [
                  Center(
                    child: Row(children: [
                      Icon(
                        Icons.report_problem,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "save Failed",
                        style: TextStyle(fontSize: 25),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  // setting tube ------------------------------------------------------------------

  //update now setting---------------------------
  // var Historylist;
  var datatemset = {};
  void use_now_setting() async {
    print("use now setting");
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:5000/loadsetting'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      datatemset = responseData['data'];
      // print(datatemset);
    }

    var kInDatatemset;
    var vInDatatemset;
    datatemset.forEach(
      (key, value) {
        kInDatatemset = key;
        vInDatatemset = value;
      },
    );
    tube_name_setting.text = datatemset[kInDatatemset]['name'].toString();
    tube_hight.text = datatemset[kInDatatemset]['tube_hight'].toString();
    tube_diameter.text = datatemset[kInDatatemset]['tube_diameter'].toString();
    tube_px.text = datatemset[kInDatatemset]['px'].toString();
    tube_mm.text = datatemset[kInDatatemset]['mm'].toString();
  }

  void use_setting_this(String idSetting) async {
    // print(id_setting);
    // send old time and new time to server
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/usesettingthis'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'new_id': (DateTime.now().millisecondsSinceEpoch).toString(),
        'old_id': idSetting,
      }),
    );
    if (response.statusCode == 200) {
      use_now_setting();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("Model version $version"),
            content: const SizedBox(
              height: 50,
              width: 200,
              child: Column(
                children: [
                  Center(
                    child: Row(children: [
                      Icon(
                        Icons.report_problem,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "can't use templat (Server error)!",
                        style: TextStyle(fontSize: 25),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void delete_setting_this(String idSetting) async {
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/deletesettingthis'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'new_id': (DateTime.now().millisecondsSinceEpoch).toString(),
        'old_id': idSetting,
      }),
    );
    if (response.statusCode == 200) {
      use_now_setting();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("Model version $version"),
            content: const SizedBox(
              height: 50,
              width: 200,
              child: Column(
                children: [
                  Center(
                    child: Row(children: [
                      Icon(
                        Icons.report_problem,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "can't delete templat (Server error)!",
                        style: TextStyle(fontSize: 25),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // send command zone----------------------------
  List<dynamic> data_list_command = [];

  final commandcontrol = TextEditingController();
  void send_command() async {
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/command_send'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'command': commandcontrol.text,
      }),
    );
    if (response.statusCode == 200) {
      data_list_command.add(commandcontrol.text);
      commandcontrol.text = '';
      use_now_setting();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("Model version $version"),
            content: const SizedBox(
              height: 50,
              width: 200,
              child: Column(
                children: [
                  Center(
                    child: Row(children: [
                      Icon(
                        Icons.report_problem,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "can't send command (Server error)!",
                        style: TextStyle(fontSize: 25),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  // send command zone----------------------------

  // setting camera zone--------------------------
  List<dynamic> camera_list_all = [];
  void camera_setting() async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:5000/list_camera'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      camera_list_all = responseData['data'];
    }
  }

  void use_camera(int cameraNumer) async {
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/use_camera_now'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'camera': camera_list_all[cameraNumer].toString(),
      }),
    );
  }

  // swich camara zone ----------------------------
  bool st_on_off_camera = false;
  void st_on_off_camera_run() {
    setState(() {
      st_on_off_camera = !st_on_off_camera;
    });
  }
  //-----------------------------------------------

  void show_list_camera() {
    if (camera_list_all.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("ERROR!"),
              content: const SizedBox(
                height: 100,
                width: 400,
                child: Row(
                  children: [
                    Icon(
                      Icons.report_problem,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("cannot load camera please chack camera"),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("camera list"),
            content: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: camera_list_all.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Icon(Icons.camera_alt_sharp),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text('${camera_list_all[index]}'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        use_camera(camera_list_all[index]);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Use')),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      st_on_off_camera_run();
                      Navigator.of(context).pop();
                      show_list_camera();
                    });
                  },
                  child: st_on_off_camera
                      ? const Text("OFF camera")
                      : const Text("ON camera")),
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // setting camera zone--------------------------

  // get list model in my commputer
  List<dynamic> list_model_in_com = [];
  void get_list_model_inmycomputer() async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:5000/get_list_model_inmycomputer'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      list_model_in_com = responseData['model_version_inmycomputer'];
      print("model in mycomputer $responseData");
      // status_detect = responseData['status_detect'];
    }
  }

  // get_list_model_inmycomputer
  // get list model from internet
  Map<String, dynamic> list_model_frominternet = {};
  void get_model_from_internet() async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:5000/get_model_from_internet'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      list_model_frominternet = responseData['model_list_all'];
      // print("get_model_from_internet $responseData['model_list_all']");
      // status_detect = responseData['status_detect'];
    }
  }

  // get list model in my commputer
  // status plasma qrcode and wait----------------
  String status_detect = 'wait';
  void status_chacking() async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:5000/status_chacking'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      status_detect = responseData['status_detect'];
    } else {
      status_detect = 'wait';
    }
  }

  void use_model_in_mycomputer(String versionOfModel) async {
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/use_model_in_mycomputer'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'model_v': versionOfModel}),
    );
  }

  // @override
  // Future<void> sendData() async {
  //   // final String t = textUser.text;
  //   // final String a = textPass.text;

  //   final response = await http.get(
  //     Uri.parse('http://kuywin.bd2-cloud.net/login'),  // Replace with your backend URL
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       // 't': t,
  //       // 'a': a,
  //     }),
  //   );
  // }

  // get image zone ---------------------------------------------------------------------
  String imageUrl = "http://127.0.0.1:2545/vdo";
  // String imageUrl_qr = "http://127.0.0.1:5000/image_qr";
  bool _updating = false;

  // function prototype

  @override
  void initState() {
    use_now_setting();
    camera_setting();
    get_model_from_internet();
    get_list_model_inmycomputer();
    print("kuy page 1");
    super.initState();
    Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      if (!_updating) {
        _updateImage();
      }
    });
    Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      if (!_updating) {
        status_chacking();
      }
    });
  }

  Future<void> _updateImage() async {
    if (!mounted) return;
    setState(() {
      _updating = true;
    });

    String newImageUrl =
        "http://127.0.0.1:2545/vdo?t=${DateTime.now().millisecondsSinceEpoch}";
    if (st_on_off_camera) {
      //chack status get image
      String newImageUrl =
          "http://127.0.0.1:2545/vdo?t=${DateTime.now().millisecondsSinceEpoch}";
      await precacheImage(NetworkImage(newImageUrl), context);
    }

    // print(newImageUrl);

    // String newimageurlQr = "http://127.0.0.1:5000/image_qr?t=${DateTime.now().millisecondsSinceEpoch}";
    // await precacheImage(NetworkImage(newimageurlQr), context);

    if (!mounted) return;
    setState(() {
      if (st_on_off_camera) {
        imageUrl = newImageUrl;
      }
      // print(imageUrl);
      // imageUrl_qr = newimageurlQr;
      // print(imageUrl_qr);
      _updating = false;
    });
  }

  @override
  void dispose() {
    // Cancel the timer or any other ongoing operations if necessary
    super.dispose();
  }

  // get image zone --------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(
        'David',
        100,
      ),
      ChartData(
        'Steve',
        90,
      ),
    ];

    // final List<Model> models = List.generate(
    //   10,
    //   (index) => Model(
    //       name: 'Model $index',
    //       version: '${index + 1.0}.0',
    //       rate: '${index + 80}%'),
    // );

    final List<Model> models =
        list_model_frominternet.keys.toList().asMap().entries.map((entry) {
      int index = entry.key;
      String key = entry.value;
      Map<String, dynamic> item = list_model_frominternet[key]!;

      bool stModelInPc = false;
      for (var model_com in list_model_in_com) {
        if (key == model_com) {
          stModelInPc = true;
          break;
        }
      }

      return Model(
          version: key.toString(),
          rate: item['rate'].toString(),
          filename: item['filename'].toString(),
          mse: item['mse'].toString(),
          performance: item['performance'].toString(),
          st_model_incom: stModelInPc);
    }).toList();

    final List<Hislist> Historylist =
        datatemset.keys.toList().asMap().entries.map((entry) {
      int index = entry.key;
      String key = entry.value;
      Map<String, dynamic> item = datatemset[key]!;

      return Hislist(
          name: item['name'],
          tube_hight: item['tube_hight'].toString(),
          tube_diameter: item['tube_diameter'].toString(),
          mm: item['mm'].toString(),
          px: item['px'].toString(),
          id: key.toString());
    }).toList();

    //apply model-------------------------------------------------------
    // final global_version = TextEditingController();
    // final global_mse = TextEditingController();
    // final global_performance = TextEditingController();

    // String global_version = "kuy";
    // String global_mse = "505";
    // String global_performance = "popo";

    void apply_show_version_model(String chooseModelVersion) {
      for (var run_version in models) {
        if (chooseModelVersion == run_version.version) {
          setState(() {
            widget.global_version = run_version.version;
            widget.global_mse = run_version.mse;
            widget.global_performance = run_version.performance;
            GUI_version_model(widget.global_version, widget.global_mse,
                widget.global_performance);
          });
          break;
        }
      }
      // print("modelllllll");
    }
    //apply------------------------------------------------------------

    void changeStateModelversion(String version, bool stModelIncom) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Model version $version"),
            content: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Model in computer"),
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: stModelIncom ? Colors.green : Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: stModelIncom ? null : () {},
                          child: const Text("Download")),
                      ElevatedButton(
                          onPressed: stModelIncom
                              ? () {
                                  apply_show_version_model(version);
                                  use_model_in_mycomputer(version);
                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: const Text("Use model"))
                    ],
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void changeStateSetting() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Load History"),
            content: SizedBox(
              height: 300,
              width: 800,
              child: Column(
                children: [
                  // Wrapping ListView.builder in an Expanded widget
                  Expanded(
                    child: ListView.builder(
                      itemCount: Historylist.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Text(Historylist[index].name),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                      "Height ${Historylist[index].tube_hight}"),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                      "Diameter ${Historylist[index].tube_diameter}"),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text("px ${Historylist[index].px}"),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text("mm ${Historylist[index].mm}"),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        use_setting_this(Historylist[index].id);
                                      },
                                      child: const Text('Use')),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        delete_setting_this(
                                            Historylist[index].id);
                                      },
                                      child: const Text('Delete')),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // int windows_width = ((MediaQuery.of(context).size).width).toInt();
    int windowsHight = ((MediaQuery.of(context).size).height).toInt();
    // print("windows_hight $windowsHight");

    return Transform.scale(
      alignment: Alignment.topLeft,
      scale: (windowsHight / 1000),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 400,
                height: 450,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "camera",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: 400,
                      height: 400,
                      color: const Color.fromARGB(255, 211, 211, 211),
                      child: Column(
                        children: [
                          st_on_off_camera
                              ? Image.network(
                                  imageUrl,
                                  width: 400,
                                  height: 400,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset("images/cat.gif", fit: BoxFit.cover)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 400,
                height: 450,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "process mode $status_detect",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: 400,
                      height: 400,
                      color: const Color.fromARGB(255, 211, 211, 211),
                      child: const Column(
                        children: [
                          // Image.network(
                          //   imageUrl_qr,
                          //   width: 400,
                          //   height: 400,
                          //   fit: BoxFit.cover,
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 400,
                height: 450,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Command",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 211, 211, 211),
                        borderRadius: BorderRadius.circular(
                            15), // Half the width/height to make it circular
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          List_command_display(data_list_command),
                          SizedBox(
                            height: 40,
                            width: 400,
                            // color: Colors.amber,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: TextField(
                                  controller: commandcontrol,
                                )),
                                ElevatedButton(
                                    onPressed: send_command,
                                    child: const Text("send")),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 400,
                height: 450,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Training Rate",
                          style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 350,
                            height: 350,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: GUI_version_model(widget.global_version,
                                widget.global_mse, widget.global_performance),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 400,
                height: 450,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Model version",
                      style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                    ),
                    const Text(
                      "List all model in record",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 56, 56, 56)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      height: 350,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: ListView.builder(
                        itemCount: models
                            .length, // replace `models` with your data source
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Row(
                                children: [
                                  Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  "images/ai.png")))),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(models[index].version),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  Text("Rate ${models[index].rate}"),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  IconButton(
                                      onPressed: () => changeStateModelversion(
                                          models[index].version,
                                          models[index].st_model_incom),
                                      icon: const Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                              subtitle: const Divider(color: Colors.black));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 400,
                height: 450,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Setting",
                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Setting Name : ${tube_name_setting.text}"),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("setting name"),
                                        content: SizedBox(
                                          width: 400,
                                          height: 100,
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: name_setting_now,
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                tube_name_setting.text =
                                                    name_setting_now.text;
                                              },
                                              child: const Text(
                                                "save",
                                                style: TextStyle(fontSize: 20),
                                              )),
                                          TextButton(
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: const Icon(Icons.edit),
                            ),
                            ElevatedButton(
                                onPressed: changeStateSetting,
                                child: const Row(
                                  children: [Text("Load History")],
                                ))
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black),
                      Container(
                        child: const Row(
                          children: [
                            Text("Tube Hight"),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 400,
                              child: TextField(
                                controller: tube_hight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: const Row(
                          children: [
                            Text("Tube Diameter"),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 400,
                              child: TextField(
                                controller: tube_diameter,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: const Row(
                          children: [
                            Text("px : mm"),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 190,
                              child: TextField(
                                controller: tube_px,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 190,
                              child: TextField(
                                controller: tube_mm,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        onPressed: show_list_camera,
                        color: const Color(0xFF5A67BA),
                        child: const SizedBox(
                          width: 400,
                          child: Text(
                            "camera setting",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        onPressed: settingapp,
                        color: const Color(0xFF5A67BA),
                        child: const SizedBox(
                          width: 400,
                          child: Text(
                            "save",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Dashboard_Widget extends StatefulWidget {
  Dashboard_Widget({super.key});
  bool st_swich_graph = true;
  // graph ---------
  var dataSource_his = [
    ChartData('01', 35),
    ChartData('02', 28),
    ChartData('03', 34),
    ChartData('04', 32),
    ChartData('05', 40),
    ChartData('06', 35),
    ChartData('07', 28),
    ChartData('08', 34),
    ChartData('09', 32),
    ChartData('10', 40),
    ChartData('11', 32),
    ChartData('12', 40),
  ];
  var dataSource_his_true = [
    ChartData('01', 35),
    ChartData('02', 28),
    ChartData('03', 34),
    ChartData('04', 32),
    ChartData('05', 40),
    ChartData('06', 35),
    ChartData('07', 28),
    ChartData('08', 34),
    ChartData('09', 32),
    ChartData('10', 40),
    ChartData('11', 32),
    ChartData('12', 40),
  ];
  bool st_download_his = true;
  //---------------

  @override
  State<Dashboard_Widget> createState() => _Dashboard_Widget();
}

// class _Dashboard_Widget extends StatelessWidget {
class _Dashboard_Widget extends State<Dashboard_Widget> {
  // _Dashboard_Widget({super.key});

  @override
  final List<Model> modelsV2 = List.generate(
    10,
    (index) => Model(
        filename: 'Model $index',
        mse: '${index + 1.0}.0',
        rate: '${index + 80}%',
        version: '$index',
        performance: '$index',
        st_model_incom: false),
  );

  // schedule-------------------------------------------------
  void schedule_end() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Load History"),
          content: const Text("kuy"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  late DateTime _selectedDate_start = DateTime.now();
  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate_start ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate_start) {
      setState(() {
        _selectedDate_start = picked;
      });
    }
  }

  late DateTime _selectedDate_end = DateTime.now();
  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate_end ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate_end) {
      setState(() {
        _selectedDate_end = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('d:M:y').format(date);
  }

  void get_history_for_graph() async {
    setState(() {
      widget.st_download_his = false;
    });
    int startDateStamp = _selectedDate_start.millisecondsSinceEpoch ~/ 1000;
    int endDateStamp = _selectedDate_end.millisecondsSinceEpoch ~/ 1000;
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/get_history_for_graph'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'start': startDateStamp.toString(),
        'end': endDateStamp.toString()
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // print('Response data: ${responseData['hisreturn']}');
      var bufData = responseData['hisreturn']["false_tube"];
      var bufData2 = responseData['hisreturn']["true_tube"];

      setState(() {
        widget.dataSource_his = [];
        bufData.forEach(
          (key, value) {
            widget.dataSource_his.add(ChartData(key, value.toDouble()));
          },
        );
        widget.dataSource_his_true = [];
        bufData2.forEach(
          (key, value) {
            widget.dataSource_his_true.add(ChartData(key, value.toDouble()));
          },
        );
        widget.st_download_his = true;
      });

      // LoadingAnimationWidget.twistingDots(
      //     leftDotColor: const Color(0xFF1A1A3F),
      //     rightDotColor: const Color(0xFFEA3799),
      //     size: 200,
      //   ),
    }
  }
  // schedule-------------------------------------------------

  void swich_work() {
    widget.st_swich_graph = !widget.st_swich_graph;
    print(widget.st_swich_graph);
    setState(() {});
  }

  Widget swich_graph() {
    if (widget.st_download_his) {
      if (widget.st_swich_graph) {
        return SizedBox(
          height: 250, // cari++++++++
          child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              primaryYAxis:
                  const NumericAxis(minimum: 0, maximum: 100, interval: 25),
              series: <CartesianSeries<ChartData, String>>[
                ColumnSeries<ChartData, String>(
                  dataSource: widget.dataSource_his,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Series 1',
                  color: const Color(0xFF5A6ACF),
                ),
                ColumnSeries<ChartData, String>(
                  dataSource: widget.dataSource_his,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Series 2',
                  color: const Color.fromARGB(0, 22, 243, 29),
                ),
                ColumnSeries<ChartData, String>(
                  dataSource: widget.dataSource_his_true,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Series 1',
                  color: const Color(0xFFF2383A),
                ),
              ]),
        );
      } else {
        return SizedBox(
          height: 250,
          child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              primaryYAxis:
                  const NumericAxis(minimum: 0, maximum: 100, interval: 25),
              series: <CartesianSeries<ChartData, String>>[
                LineSeries<ChartData, String>(
                  dataSource: [
                    // Bind data source
                    ChartData('01', 35),
                    ChartData('02', 28),
                    ChartData('03', 34),
                    ChartData('04', 32),
                    ChartData('05', 40),
                    ChartData('06', 35),
                    ChartData('07', 28),
                    ChartData('08', 34),
                    ChartData('09', 32),
                    ChartData('10', 40),
                    ChartData('11', 32),
                    ChartData('12', 40),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Series 1',
                  color: const Color(0xFF5A6ACF),
                ),
                LineSeries<ChartData, String>(
                  dataSource: [
                    // Bind data source
                    ChartData('01', 35),
                    ChartData('02', 28),
                    ChartData('03', 34),
                    ChartData('04', 32),
                    ChartData('05', 40),
                    ChartData('06', 35),
                    ChartData('07', 28),
                    ChartData('08', 34),
                    ChartData('09', 32),
                    ChartData('10', 40),
                    ChartData('11', 32),
                    ChartData('12', 40),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Series 2',
                  color: const Color.fromARGB(0, 22, 243, 29),
                ),
                LineSeries<ChartData, String>(
                  dataSource: [
                    // Bind data source
                    ChartData('01', 5),
                    ChartData('02', 56),
                    ChartData('03', 70),
                    ChartData('04', 88),
                    ChartData('05', 75),
                    ChartData('06', 5),
                    ChartData('07', 28),
                    ChartData('08', 34),
                    ChartData('09', 8),
                    ChartData('10', 89),
                    ChartData('11', 56),
                    ChartData('12', 69),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Series 1',
                  color: const Color(0xFFF2383A),
                ),
              ]),
        );
      }
    } else {
      return SizedBox(
        height: 250,
        child: Row(
          children: [
            const SizedBox(
              width: 400,
            ),
            LoadingAnimationWidget.dotsTriangle(
              color: const Color.fromARGB(255, 84, 84, 255),
              size: 100,
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
    // if (!_updating) {
    //   _updateImage();
    // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    int windowsHight = ((MediaQuery.of(context).size).height).toInt();
    return Transform.scale(
      alignment: Alignment.topLeft,
      scale: (windowsHight / 1000),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 920,
                height: 900,
                color: const Color.fromARGB(255, 222, 240, 121),
                child: Column(
                  children: [
                    Container(
                      height: 450,
                      width: 920,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Dashboard",
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Detecttion lost",
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'Poppins')),
                                SizedBox(
                                  width: 700,
                                  // color: Colors.amber,
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            _selectDateStart(context);
                                          },
                                          child: const Text(
                                            "Date start",
                                            style: TextStyle(
                                                color: Color(0xFF5A6ACF)),
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            _selectDateEnd(context);
                                          },
                                          child: const Text(
                                            "Date stop",
                                            style: TextStyle(
                                                color: Color(0xFF5A6ACF)),
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: get_history_for_graph,
                                          child: const Text("Get history",
                                              style: TextStyle(
                                                  color: Color(0xFF5A6ACF)))),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: swich_work,
                                          child: const Text(
                                            "Switch graph",
                                            style: TextStyle(
                                                color: Color(0xFF5A6ACF)),
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "View report",
                                            style: TextStyle(
                                                color: Color(0xFF5A6ACF)),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "3 / 15",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 15,
                                ),
                                Text(
                                  "20 %",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  " vs last week",
                                  style: TextStyle(fontFamily: 'Poppins'),
                                )
                              ],
                            ),
                          ),
                          swich_graph(),
                          Container(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Color(0xFF5A6ACF),
                                  size: 20,
                                ),
                                const Text(" This Week"),
                                const SizedBox(
                                  width: 50,
                                ),
                                const Icon(
                                  Icons.circle,
                                  color: Color(0xFFF2383A),
                                  size: 20,
                                ),
                                const Text(" Last Week"),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                    "query : ${_formatDate(_selectedDate_start)} to ${_formatDate(_selectedDate_end)}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 450,
                      width: 920,
                      color: const Color.fromARGB(255, 200, 202, 201),
                      child: Row(
                        children: [
                          Container(
                            height: 450,
                            width: 460,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                              children: [
                                Container(
                                  width: 400,
                                  height: 450,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Training Rate",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Poppins'),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 350,
                                              height: 350,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: 350,
                                                    height: 350,
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Image.asset(
                                                            "images/canvas.png",
                                                            fit: BoxFit.fill),
                                                      ],
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    left: 100, // ระบุค่าพิกัด x
                                                    top: 100, // ระบุค่าพิกัด y
                                                    child: Text(
                                                      "1.1.0",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    left: 70, // ระบุค่าพิกัด x
                                                    top: 140, // ระบุค่าพิกัด y
                                                    child: Text(
                                                      "Model version",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    left: 200, // ระบุค่าพิกัด x
                                                    top: 150, // ระบุค่าพิกัด y
                                                    child: Text(
                                                      "001%",
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    left: 230, // ระบุค่าพิกัด x
                                                    top: 200, // ระบุค่าพิกัด y
                                                    child: Text(
                                                      "MSE",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    left: 55, // ระบุค่าพิกัด x
                                                    top: 240, // ระบุค่าพิกัด y
                                                    child: Text(
                                                      "99%",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    left: 30, // ระบุค่าพิกัด x
                                                    top: 280, // ระบุค่าพิกัด y
                                                    child: Text(
                                                      "Performance",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 450,
                            width: 460,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Model version",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Poppins'),
                                ),
                                const Text(
                                  "List all model in record",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 56, 56, 56)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 400,
                                  height: 350,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: ListView.builder(
                                    itemCount: modelsV2
                                        .length, // replace `models` with your data source
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                          title: Row(
                                            children: [
                                              Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              "images/ai.png")))),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(modelsV2[index].version),
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              Text(
                                                  "Rate ${modelsV2[index].rate}"),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.arrow_forward_ios))
                                            ],
                                          ),
                                          subtitle: const Divider(
                                              color: Colors.black));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 400,
                height: 900,
                // color: Color.fromARGB(255, 214, 252, 1),
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      height: 450,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Setting",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Poppins'),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Setting Name : kuytest"),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Row(
                                        children: [Text("Load History")],
                                      ))
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black),
                            Container(
                              child: const Row(
                                children: [
                                  Text("Tube Hight"),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 300,
                                    child: TextField(),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Save"))
                                ],
                              ),
                            ),
                            Container(
                              child: const Row(
                                children: [
                                  Text("Tube Diameter"),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 300,
                                    child: TextField(),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Save"))
                                ],
                              ),
                            ),
                            Container(
                              child: const Row(
                                children: [
                                  Text("px : mm"),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 140,
                                    child: TextField(),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 140,
                                    child: TextField(),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Save"))
                                ],
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: 400,
                      height: 450,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Notification",
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                          ),
                          const Text(
                            "3",
                            style:
                                TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 15,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "2.1%",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      " vs last week",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("View Report")),
                              ],
                            ),
                          ),
                          const Text(
                            "Detect from 1-6 Jan, 2024",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w100),
                          ),
                          // grap--------------
                          SizedBox(
                            height: 250, // cari++++++++
                            child: SfCartesianChart(
                                primaryXAxis: const CategoryAxis(),
                                primaryYAxis: const NumericAxis(
                                    minimum: 0, maximum: 100, interval: 25),
                                series: <CartesianSeries<ChartData, String>>[
                                  LineSeries<ChartData, String>(
                                    dataSource: [
                                      // Bind data source
                                      ChartData('01', 35),
                                      ChartData('02', 28),
                                      ChartData('03', 34),
                                      ChartData('04', 32),
                                      ChartData('05', 40),
                                      ChartData('06', 35),
                                      ChartData('07', 28),
                                      ChartData('08', 34),
                                      ChartData('09', 32),
                                      ChartData('10', 40),
                                      ChartData('11', 32),
                                      ChartData('12', 40),
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    name: 'Series 1',
                                    color: const Color(0xFF5A6ACF),
                                  ),
                                  LineSeries<ChartData, String>(
                                    dataSource: [
                                      // Bind data source
                                      ChartData('01', 5),
                                      ChartData('02', 56),
                                      ChartData('03', 70),
                                      ChartData('04', 88),
                                      ChartData('05', 75),
                                      ChartData('06', 5),
                                      ChartData('07', 28),
                                      ChartData('08', 34),
                                      ChartData('09', 8),
                                      ChartData('10', 89),
                                      ChartData('11', 56),
                                      ChartData('12', 69),
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    name: 'Series 1',
                                    color: const Color(0xFFF2383A),
                                  ),
                                ]),
                          ),
                          Container(
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF5A6ACF),
                                  size: 20,
                                ),
                                Text(" Today"),
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFFF2383A),
                                  size: 20,
                                ),
                                Text(" Yesterday"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Train_Widget extends StatefulWidget {
  const Train_Widget({super.key});

  @override
  State<Train_Widget> createState() => _Train_WidgetState();
}

class _Train_WidgetState extends State<Train_Widget> {
  @override
  void initState() {
    super.initState();
    _launchURL();
  }
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.r_mobiledata),
        Text('open colab for train model'),
      ],
    );
  }
}

class DataCenter_Widget extends StatefulWidget {
  DataCenter_Widget({super.key});
  bool display_swich = true;

  //good pool
  List<bool> list_bool_del_good = <bool>[];
  List<bool> list_bool_move_to_bad = <bool>[];
  List<bool> list_bool_save_to_good = <bool>[];
  List<String> list_image_good_pool = <String>[];
  late List GoodPool_list;

  //bad pool
  List<bool> list_bool_del_bad = <bool>[];
  List<bool> list_bool_move_to_good = <bool>[];
  List<bool> list_bool_save_to_bad = <bool>[];
  List<String> list_image_bad_pool = <String>[];
  late List badPool_list;


  List<dynamic> list_model_in_com = [];


  @override
  State<DataCenter_Widget> createState() => _DataCenter_WidgetState();
}

class _DataCenter_WidgetState extends State<DataCenter_Widget> {
  //zone of good pool
  void _toggleCheckbox_good(bool? value, int index_list) {
    setState(() {
      widget.list_bool_del_good[index_list] = value ?? false;
      if(widget.list_bool_del_good[index_list] == true){
        widget.list_bool_move_to_bad[index_list] = false;
        widget.list_bool_save_to_good[index_list] = false;
      }
    });
  }

  void _toggleCheckbox_move_to_bad(bool? value, int index_list) {
    setState(() {
      widget.list_bool_move_to_bad[index_list] = value ?? false;
      if(widget.list_bool_move_to_bad[index_list] == true){
        widget.list_bool_del_good[index_list] = false;
        widget.list_bool_save_to_good[index_list] = false;
      }
    });
  }

  void _toggleCheckbox_save_good_to_dataset(bool? value, int index_list) {
    setState(() {
      widget.list_bool_save_to_good[index_list] = value ?? false;
      if(widget.list_bool_save_to_good[index_list] == true){
        widget.list_bool_move_to_bad[index_list] = false;
        widget.list_bool_del_good[index_list] = false;
      }
    });
  }
  //--end---
  //zone of bad pool
  void _toggleCheckbox_bad(bool? value, int index_list) {
    setState(() {
      widget.list_bool_del_bad[index_list] = value ?? false;
      if(widget.list_bool_del_bad[index_list] == true){
        widget.list_bool_move_to_good[index_list] = false;
        widget.list_bool_save_to_bad[index_list] = false;
      }
    });
  }

  void _toggleCheckbox_move_to_good(bool? value, int index_list) {
    setState(() {
      widget.list_bool_move_to_good[index_list] = value ?? false;
      if(widget.list_bool_move_to_good[index_list] == true){
        widget.list_bool_del_bad[index_list] = false;
        widget.list_bool_save_to_bad[index_list] = false;
      }
    });
  }

  void _toggleCheckbox_save_bad_to_dataset(bool? value, int index_list) {
    setState(() {
      widget.list_bool_save_to_bad[index_list] = value ?? false;
      if(widget.list_bool_save_to_bad[index_list] == true){
        widget.list_bool_move_to_good[index_list] = false;
        widget.list_bool_del_bad[index_list] = false;
      }
    });
  }

  Future<void> runGetListFromGoodPool() async {
    final response = await http.get(
      Uri.parse(
          'http://210.246.215.145:1234/get_name_data_set_in_good_pool'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      widget.GoodPool_list = responseData['files'];

      widget.list_bool_del_good = [];
      widget.list_image_good_pool = [];
      widget.list_bool_move_to_bad = [];

      for(var i in widget.GoodPool_list){
        widget.list_bool_del_good.add(false);
        widget.list_bool_move_to_bad.add(false);
        widget.list_bool_save_to_good.add(true);
        widget.list_image_good_pool.add(i);
      }
      // print(responseData['files']);
    }
  }
    Future<void> runGetListFromBadPool() async {
    final response = await http.get(
      Uri.parse(
          'http://210.246.215.145:1234/get_name_data_set_in_bad_pool'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      widget.badPool_list = responseData['files'];

      widget.list_bool_del_bad = [];
      widget.list_image_bad_pool = [];
      widget.list_bool_move_to_good = [];

      for(var i in widget.badPool_list){
        widget.list_bool_del_bad.add(false);
        widget.list_bool_move_to_good.add(false);
        widget.list_bool_save_to_bad.add(true);
        widget.list_image_bad_pool.add(i);
      }
      // print(responseData['files']);
    }
  }

  Future<void> processAddCommand() async {
    // await Future.delayed(Duration(seconds: 3)); // Replace with your actual task
    //save to
    List<String> buf_list_bool_save_to_good_name_file = [];
    List<String> buf_list_bool_move_to_bad_name_file = [];
    List<String> buf_list_bool_del_good_name_file = [];

    for(int i =  0;i<widget.list_image_good_pool.length;i++){
      if(widget.list_bool_save_to_good[i] == true){
        buf_list_bool_save_to_good_name_file.add(widget.list_image_good_pool[i]);
      }
      if(widget.list_bool_move_to_bad[i] == true){
        buf_list_bool_move_to_bad_name_file.add(widget.list_image_good_pool[i]);
      }
      if(widget.list_bool_del_good[i] == true){
        buf_list_bool_del_good_name_file.add(widget.list_image_good_pool[i]);
      }
    }

    List<String> buf_list_bool_save_to_bad_name_file = [];
    List<String> buf_list_bool_move_to_good_name_file = [];
    List<String> buf_list_bool_del_bad_name_file = [];

    for(int i =  0;i<widget.list_image_bad_pool.length;i++){
      if(widget.list_bool_save_to_bad[i] == true){
        buf_list_bool_save_to_bad_name_file.add(widget.list_image_bad_pool[i]);
      }
      if(widget.list_bool_move_to_good[i] == true){
        buf_list_bool_move_to_good_name_file.add(widget.list_image_bad_pool[i]);
      }
      if(widget.list_bool_del_bad[i] == true){
        buf_list_bool_del_bad_name_file.add(widget.list_image_bad_pool[i]);
      }
    }

    //pool good move to bad
    final response1 = await http.post(
      Uri.parse('http://210.246.215.145:1234/move_or_delete_dataset'),
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        "mode": "good_to_bad",
        "filename": buf_list_bool_move_to_bad_name_file,
      }),
    );

    //pool bad move to good
    final response2 = await http.post(
      Uri.parse('http://210.246.215.145:1234/move_or_delete_dataset'),
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        "mode": "bad_to_good",
        "filename": buf_list_bool_move_to_good_name_file,
      }),
    );

    //pool delets good
    final response3 = await http.post(
      Uri.parse('http://210.246.215.145:1234/move_or_delete_dataset'),
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        "mode": "delete",
        "filename": buf_list_bool_del_good_name_file,
        "folder_name": "good"
      }),
    );

    //pool delets bad
    final response4 = await http.post(
      Uri.parse('http://210.246.215.145:1234/move_or_delete_dataset'),
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        "mode": "delete",
        "filename": buf_list_bool_del_bad_name_file,
        "folder_name": "bad"
      }),
    );
    setState(() {});
  }

  Future<void> move_all_to_train() async{
    final response5 = await http.post(
      Uri.parse('http://210.246.215.145:1234/move_or_delete_dataset_pool_to_train'),
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        "mode":"pool_to_train",
      }),
    );
  }

  void runPopupLoading() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Processing'),
              LoadingAnimationWidget.dotsTriangle(
                color: Color.fromARGB(255, 106, 55, 248),
                size: 150,
              ),
              SizedBox(height: 20),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
    await processAddCommand();
    Navigator.of(context, rootNavigator: true).pop();
  }
  void runPopupLoading_move_to_train() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Processing'),
              LoadingAnimationWidget.dotsTriangle(
                color: Color.fromARGB(255, 106, 55, 248),
                size: 150,
              ),
              SizedBox(height: 20),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
    await move_all_to_train();
    Navigator.of(context, rootNavigator: true).pop();
  }


  @override
  void initState() {
    super.initState();
    runGetListFromGoodPool();
    runGetListFromBadPool();
    runGetListFromGoodPool();
    runGetListFromBadPool();
  }

  Widget Goodrender_image(){
    return SizedBox(
          height: 800,
          width: 1600,
          child: Container(
            child: SingleChildScrollView(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: widget.list_bool_del_good.length,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        Row(children: [
                          SizedBox(width: 25,),
                          Checkbox(
                            value: widget.list_bool_move_to_bad[index],
                            onChanged: (bool? value) {
                              _toggleCheckbox_move_to_bad(value, index);
                            },
                          ),
                          Text("move to bad"),
                          // SizedBox(width: 10,),
                          Checkbox(
                            value: widget.list_bool_del_good[index],
                            onChanged: (bool? value) {
                              _toggleCheckbox_good(value, index);
                            },
                          ),
                          Text("delet"),
                          // SizedBox(width: 10,),
                          Checkbox(
                            value: widget.list_bool_save_to_good[index],
                            onChanged: (bool? value) {
                              _toggleCheckbox_save_good_to_dataset(value, index);
                            },
                          ),
                          Text("save"),
                        ],),
                        Image.network("http://210.246.215.145:1234/show/good/${widget.list_image_good_pool[index]}",
                        height: 250,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
  }

  Widget badrender_image(){
    return SizedBox(
          height: 800,
          width: 1600,
          child: Container(
            child: SingleChildScrollView(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: widget.list_image_bad_pool.length,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        Row(children: [
                          SizedBox(width: 25,),
                          Checkbox(
                            value: widget.list_bool_move_to_good[index],
                            onChanged: (bool? value) {
                              _toggleCheckbox_move_to_good(value, index);
                            },
                          ),
                          Text("move to good"),
                          // SizedBox(width: 10,),
                          Checkbox(
                            value: widget.list_bool_del_bad[index],
                            onChanged: (bool? value) {
                              _toggleCheckbox_bad(value, index);
                            },
                          ),
                          Text("delet"),
                          // SizedBox(width: 10,),
                          Checkbox(
                            value: widget.list_bool_save_to_bad[index],
                            onChanged: (bool? value) {
                              _toggleCheckbox_save_bad_to_dataset(value, index);
                            },
                          ),
                          Text("save"),
                        ],),
                        Image.network("http://210.246.215.145:1234/show/bad/${widget.list_image_bad_pool[index]}",
                        height: 250,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
  }
  
  
  void set_mode_display(){
    setState(() {
      widget.display_swich = !widget.display_swich;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1300,
          height: 50,
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                onPressed: () {setState(() {
                  widget.display_swich = true;
                  runGetListFromGoodPool();
                });},
                color: widget.display_swich ? Color.fromARGB(255, 138, 148, 209):const Color(0xFF5A67BA),
                child: const SizedBox(
                  width: 150,
                  child: Text(
                    "Good",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {setState(() {
                  widget.display_swich = false;
                  runGetListFromBadPool();
                });},
                color: widget.display_swich?const Color(0xFF5A67BA):Color.fromARGB(255, 138, 148, 209),
                child: const SizedBox(
                  width: 150,
                  child: Text(
                    "Bad",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  runPopupLoading();
                },
                color: const Color(0xFF5A67BA),
                child: const SizedBox(
                  width: 150,
                  child: Text(
                    "Process",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  runPopupLoading_move_to_train();
                },
                color: const Color(0xFF5A67BA),
                child: const SizedBox(
                  width: 150,
                  child: Text(
                    "move to train",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        widget.display_swich?Goodrender_image():badrender_image(),
      ],
    );
  }
}


class DataCenter_for_train extends StatefulWidget {
  DataCenter_for_train({super.key});
  bool display_swich = true;

  //good pool
  List<String> list_image_good_pool = <String>[];
  late List GoodPool_list;

  //bad pool
  List<String> list_image_bad_pool = <String>[];
  late List badPool_list;


  @override
  State<DataCenter_for_train> createState() => _DataCenter_WidgetState_fortrain_model();
}

class _DataCenter_WidgetState_fortrain_model extends State<DataCenter_for_train> {

  Future<void> runGetListFromGoodPool() async {
    final response = await http.get(
      Uri.parse(
          'http://210.246.215.145:1234/get_name_data_set_in_good_train'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      widget.GoodPool_list = responseData['files'];
      widget.list_image_good_pool = [];
      for(var i in widget.GoodPool_list){
        widget.list_image_good_pool.add(i);
      }
      // print(responseData['files']);
    }
  }
    Future<void> runGetListFromBadPool() async {
    final response = await http.get(
      Uri.parse(
          'http://210.246.215.145:1234/get_name_data_set_in_bad_train'), // Replace with your backend URL
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      widget.badPool_list = responseData['files'];
      widget.list_image_bad_pool = [];
      for(var i in widget.badPool_list){
        widget.list_image_bad_pool.add(i);
      }
      // print(responseData['files']);
    }
  }
    
  Future<void> move_all_to_pool() async{
    final response5 = await http.post(
      Uri.parse('http://210.246.215.145:1234/move_or_delete_dataset_pool_to_train'),
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        "mode":"train_to_pool",
      }),
    );
  }

  void runPopupLoading_move_to_pool() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Processing'),
              LoadingAnimationWidget.dotsTriangle(
                color: Color.fromARGB(255, 106, 55, 248),
                size: 150,
              ),
              SizedBox(height: 20),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
    await move_all_to_pool();
    Navigator.of(context, rootNavigator: true).pop();
  }


  @override
  void initState() {
    super.initState();
    // runGetListFromGoodPool();
    // runGetListFromBadPool();
    // runGetListFromGoodPool();
    // runGetListFromBadPool();
  }

  Widget Goodrender_image(){
    print(widget.list_image_good_pool);
    return SizedBox(
          height: 800,
          width: 1600,
          child: Container(
            child: SingleChildScrollView(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: widget.list_image_good_pool.length,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        Image.network("http://210.246.215.145:1234/show/train_good/${widget.list_image_good_pool[index]}",
                        height: 250,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
  }

  Widget badrender_image(){
    return SizedBox(
          height: 800,
          width: 1600,
          child: Container(
            child: SingleChildScrollView(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: widget.list_image_bad_pool.length,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        Image.network("http://210.246.215.145:1234/show/train_bad/${widget.list_image_bad_pool[index]}",
                        height: 250,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
  }
  
  
  void set_mode_display(){
    setState(() {
      widget.display_swich = !widget.display_swich;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1300,
          height: 50,
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                onPressed: () {setState(() {
                  widget.display_swich = true;
                  runGetListFromGoodPool();
                });},
                color: widget.display_swich ? Color.fromARGB(255, 138, 148, 209):const Color(0xFF5A67BA),
                child: const SizedBox(
                  width: 150,
                  child: Text(
                    "Good",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {setState(() {
                  widget.display_swich = false;
                  runGetListFromBadPool();
                });},
                color: widget.display_swich?const Color(0xFF5A67BA):Color.fromARGB(255, 138, 148, 209),
                child: const SizedBox(
                  width: 150,
                  child: Text(
                    "Bad",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  runPopupLoading_move_to_pool();
                },
                color: const Color(0xFF5A67BA),
                child: const SizedBox(
                  width: 150,
                  child: Text(
                    "move to pool",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        widget.display_swich?Goodrender_image():badrender_image(),
      ],
    );
  }
}


_launchURL() async {
  final Uri url = Uri.parse(
      'https://colab.research.google.com/drive/1Yq_w4lpbOx-ALFTP9RZY-fkpBkhsoLQp?usp=sharing');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class Model {
  final String version;
  final String rate;
  final String filename;
  final String mse;
  final String performance;
  final bool st_model_incom;

  Model(
      {required this.filename,
      required this.version,
      required this.rate,
      required this.mse,
      required this.performance,
      required this.st_model_incom});
}

class Hislist {
  final String name;
  final String tube_hight;
  final String tube_diameter;
  final String mm;
  final String px;
  final String id;
  Hislist(
      {required this.name,
      required this.tube_hight,
      required this.tube_diameter,
      required this.mm,
      required this.px,
      required this.id});
}

class ChartData_dasboard {
  final String x;
  final int y;
  // ChartData('01', 35);

  ChartData_dasboard(this.x, this.y);
}

Widget GUI_version_model(
    String globalVersion, String globalMse, String globalPerformance) {
  return Stack(
    children: [
      Container(
        width: 350,
        height: 350,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("images/canvas.png", fit: BoxFit.fill),
          ],
        ),
      ),
      Positioned(
        left: 100, // ระบุค่าพิกัด x
        top: 100, // ระบุค่าพิกัด y
        child: Text(
          globalVersion,
          style: const TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Poppins'),
        ),
      ),
      const Positioned(
        left: 70, // ระบุค่าพิกัด x
        top: 140, // ระบุค่าพิกัด y
        child: Text(
          "Model version",
          style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Poppins'),
        ),
      ),
      Positioned(
        left: 200, // ระบุค่าพิกัด x
        top: 150, // ระบุค่าพิกัด y
        child: Text(
          globalMse,
          style: const TextStyle(
              fontSize: 40,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Poppins'),
        ),
      ),
      const Positioned(
        left: 230, // ระบุค่าพิกัด x
        top: 200, // ระบุค่าพิกัด y
        child: Text(
          "MSE",
          style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Poppins'),
        ),
      ),
      Positioned(
        left: 55, // ระบุค่าพิกัด x
        top: 240, // ระบุค่าพิกัด y
        child: Text(
          globalPerformance,
          style: const TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Poppins'),
        ),
      ),
      const Positioned(
        left: 30, // ระบุค่าพิกัด x
        top: 280, // ระบุค่าพิกัด y
        child: Text(
          "Performance",
          style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Poppins'),
        ),
      ),
    ],
  );
}

Widget List_command_display(List dataListCommand) {
  return Expanded(
    child: ListView.builder(
      itemCount: dataListCommand.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text("$index ${dataListCommand[index]}"),
              ],
            ),
          ],
        );
      },
    ),
  );
}

Map<dynamic, dynamic> data_dashdoard_histry() {
  return {};
}
