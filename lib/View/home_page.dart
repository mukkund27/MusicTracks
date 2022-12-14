import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musicplayer/Controller/internetcheckerController.dart';
import 'package:musicplayer/View/info_page.dart';
import '../Controller/track_service.dart';
import '../Model/track_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InternetCheckerController>(
      builder: (InternetCheckerController controller) {
        if (controller.isInternet) {
          if (controller.internetStatus) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Tracks"),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.bookmark_border))
                ],
              ),
              body: FutureBuilder(
                future: GetProductService.GetData(),
                builder:
                    (BuildContext context, AsyncSnapshot<TrackModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          snapshot.data!.message!.body!.trackList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var Data = snapshot
                            .data!.message!.body!.trackList![index].track;
                        return ListTile(
                          onTap: () async {
                            final box = GetStorage();
                            var id = Data!.trackId.toString();
                            await box.write("track_id", id);

                            Get.to(InfoPage(
                              name: Data.trackName.toString(),
                              albumName: Data.albumName.toString(),
                              artist: Data.artistName.toString(),
                              explicit: Data.explicit.toString(),
                              rating: Data.trackRating.toString(),
                            ));
                          },
                          leading: Image.asset(
                            "assets/images/music_image.png",
                            height: 40,
                            width: 40,
                          ),
                          title: Text(
                            Data!.trackName.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(Data.albumName.toString(), maxLines: 1),
                          trailing: Text(Data.artistName.toString()),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            thickness: 1,
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                },
              ),
            );
          } else {
            return Material(
                child: Center(
                    child: Image.asset(
              "assets/images/wifi.png",
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            )));
          }
        } else {
          if (controller.firsttime) {
            return const Material();
          } else {
            return Material(
              child: Center(
                  child: Image.asset(
                "assets/images/wifi.png",
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              )),
            );
          }
        }
      },
      init: InternetCheckerController(),
    );
  }
}
