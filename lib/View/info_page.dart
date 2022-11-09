import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:musicplayer/Controller/track_service.dart';

import 'package:musicplayer/View/no_connection.dart';
import '../Controller/internetcheckerController.dart';
import '../Model/lyrics_model.dart';

class InfoPage extends StatefulWidget {
  final name;
  final artist;
  final albumName;
  final explicit;
  final rating;

  const InfoPage({
    Key? key,
    this.name,
    this.artist,
    this.albumName,
    this.explicit,
    this.rating,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return GetBuilder<InternetCheckerController>(
      builder: (InternetCheckerController controller) {
        if (controller.isInternet) {
          return Material();
        } else {
          if (controller.internet) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text("Track Details"),
              ),
              body: Padding(
                padding: EdgeInsets.only(left: h * 0.015, right: h * 0.010),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleText(
                        text: "Name",
                      ),
                      SubTitleText(
                        text: widget.name,
                      ),
                      const TitleText(
                        text: "Artist",
                      ),
                      SubTitleText(
                        text: widget.artist,
                      ),
                      const TitleText(
                        text: "Album Name",
                      ),
                      SubTitleText(
                        text: widget.albumName,
                      ),
                      const TitleText(
                        text: "Explicit",
                      ),
                      widget.explicit == 1
                          ? const SubTitleText(
                              text: "True",
                            )
                          : const SubTitleText(
                              text: "False",
                            ),
                      const TitleText(
                        text: "Rating",
                      ),
                      SubTitleText(
                        text: widget.rating,
                      ),
                      const TitleText(
                        text: "Lyrics",
                      ),
                      SizedBox(
                        height: h * 0.004,
                      ),
                      FutureBuilder(
                        future: GetProductService.GetLyrics(),
                        builder: (BuildContext context,
                            AsyncSnapshot<LyricsModel> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text(
                              snapshot.data!.message!.body!.lyrics!.lyricsBody
                                  .toString(),
                              style: TextStyle(fontSize: w * 0.048),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                      SizedBox(
                        height: h * 0.008,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Material(
              child: Center(
                child: Text("No Internet"),
              ),
            );
          }
        }
      },
    );
  }
}

class TitleText extends StatelessWidget {
  final text;
  const TitleText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.060),
    );
  }
}

class SubTitleText extends StatelessWidget {
  final text;
  const SubTitleText({Key? key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: w * 0.050),
        ),
        SizedBox(
          height: h * 0.008,
        ),
      ],
    );
  }
}
