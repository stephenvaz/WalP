import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:walp/firestore_test.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

//YoYHKjpwTUiD2hv3t0wsLuNl43G0HYdomUMA0w21p-c
class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/gif/login.gif',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: Explore2(),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class FullImageView extends StatelessWidget {
  dynamic url;
  FullImageView({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: const Alignment(-1, -1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      ),
    );
  }
}

class Explore2 extends StatefulWidget {
  const Explore2({Key? key}) : super(key: key);

  @override
  _Explore2State createState() => _Explore2State();
}

class _Explore2State extends State<Explore2> {
  dynamic urlData;
  void getApiData() async {
    var url = Uri.parse(
        'https://api.unsplash.com/photos/?per_page=30&client_id=YoYHKjpwTUiD2hv3t0wsLuNl43G0HYdomUMA0w21p-c');
    final res = await http.get(url);
    setState(() {
      urlData = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.account_circle,
                  size: 35,
                  color: Colors.white.withOpacity(0.7),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
              );
            },
          ),
          title: const Text('Explore'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: 'Developing');
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.7),
                  size: 35,
                ))
          ],
        ),
        body: Center(
          child: urlData == null
              ? const CircularProgressIndicator()
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(4, 2, 4, 0),
                  itemCount: 30,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 6,
                      crossAxisCount: 2,
                      crossAxisSpacing: 6),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullImageView(
                                      url: urlData[i]['urls']['regular'],
                                    )));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(urlData[i]['urls']['thumb']),
                            fit: BoxFit.cover),
                      )),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
