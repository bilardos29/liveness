import 'dart:io';
import 'package:flutter/material.dart';
import 'package:liveness_cam/liveness_cam.dart';

class KakzakiScreen extends StatefulWidget {
  const KakzakiScreen({super.key});

  @override
  State<KakzakiScreen> createState() => _KakzakiScreenState();
}

class _KakzakiScreenState extends State<KakzakiScreen> {
  final _livenessCam = LivenessCam();

  File? result;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Liveness Cam'),
        ),
        body: Center(
          child: Column(
            children: [
              result != null ? Image.file(result!) : Container(),
              const SizedBox(
                height: 20,
              ),
              Builder(builder: (ctx) {
                return ElevatedButton(
                    onPressed: () {
                      _livenessCam.start().then((value) {
                        if (value != null) {
                          setState(() {
                            result = value;
                          });
                        }
                      });
                    },
                    child: const Text(
                      "Start",
                      style: TextStyle(fontSize: 19),
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
