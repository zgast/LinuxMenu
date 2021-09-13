import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:settings_ui/settings_ui.dart';

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> envVars = Platform.environment;
    path = envVars['HOME'].toString();
    path = path + "/.setting-scripts";
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: 'Settings',
                      tiles: [
                        SettingsTile(
                          title: 'Bluetooth',
                          leading: Icon(Icons.bluetooth),
                          onPressed: (BuildContext context) async {
                            await _displayTextInputDialog(context);

                            shell.run(
                                "bash $path/commands/settings/bluetooth.sh $valueText");
                            valueText = "";
                          },
                        ),
                        SettingsTile(
                          title: 'Internet',
                          leading: Icon(Icons.wifi),
                          onPressed: (BuildContext context) async {
                            await _displayTextInputDialog(context);

                            shell.run(
                                "bash $path/commands/settings/internet.sh $valueText");
                            valueText = "";
                          },
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Brightness',
                      tiles: [
                        SettingsTile(
                          title: 'Brightness up',
                          leading: Icon(Icons.brightness_5),
                          onPressed: (BuildContext context) {
                            shell.run("bash $path/commands/brightness/up.sh");
                          },
                        ),
                        SettingsTile(
                          title: 'Brightness down',
                          leading: Icon(Icons.light_mode),
                          onPressed: (BuildContext context) {
                            String os = Platform.operatingSystem;
                            String home = "";
                            Map<String, String> envVars = Platform.environment;
                            print(os);
                            shell.run("bash $path/commands/brightness/down.sh");
                          },
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Sound',
                      tiles: [
                        SettingsTile(
                          title: 'Sound up',
                          leading: Icon(Icons.volume_up),
                          onPressed: (BuildContext context) {
                            shell.run("bash $path/commands/sound/up.sh");
                          },
                        ),
                        SettingsTile(
                          title: 'Sound down',
                          leading: Icon(Icons.volume_down),
                          onPressed: (BuildContext context) {
                            shell.run("bash $path/commands/sound/down.sh");
                          },
                        ),
                        SettingsTile(
                          title: 'Sound mute',
                          leading: Icon(Icons.volume_off),
                          onPressed: (BuildContext context) {
                            shell.run("bash $path/commands/sound/mute.sh");
                          },
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Actions',
                      tiles: [
                        SettingsTile(
                          title: 'Lock',
                          leading: Icon(Icons.lock),
                          onPressed: (BuildContext context) async {
                            shell.run("bash $path/commands/actions/lock.sh ");
                          },
                        ),
                        SettingsTile(
                          title: 'Log out',
                          leading: Icon(Icons.logout),
                          onPressed: (BuildContext context) async {
                            await _displayTextInputDialog(context);

                            shell.run(
                                "bash $path/commands/actions/logout.sh $valueText");
                            valueText = "";
                          },
                        ),
                        SettingsTile(
                          title: 'Reboot',
                          leading: Icon(Icons.restart_alt),
                          onPressed: (BuildContext context) async {
                            await _displayTextInputDialog(context);

                            shell.run(
                                "bash $path/commands/actions/reboot.sh $valueText");
                            valueText = "";
                          },
                        ),
                        SettingsTile(
                          title: 'Power off',
                          leading: Icon(Icons.power_settings_new),
                          onPressed: (BuildContext context) async {
                            await _displayTextInputDialog(context);

                            shell.run(
                                "bash $path/commands/actions/shutdown.sh $valueText");
                            valueText = "";
                          },
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  var shell = Shell();

  String codeDialog = "";
  String valueText = "";
  String path = "";

  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter sudo password'),
            content: TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  codeDialog = valueText;
                  _textFieldController.clear();
                  Navigator.pop(context);
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "password"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    _textFieldController.clear();
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
