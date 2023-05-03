import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:muzic/const/textStyle.dart';
import 'package:muzic/controller/player_controller.dart';
import 'package:muzic/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../const/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: whiteColor,
          ),
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: Text(
          'Muzic',
          style: ourTextStyle(
            family: 'Barlow-Regular',
            size: 20,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            sortType: null,
          ),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Song'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: Obx(
                              ()=> ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: bgColor,
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              style: ourTextStyle(
                                family: 'Barlow-Bold',
                                size: 15,
                              ),
                            ),
                            subtitle: Text(
                              "${snapshot.data![index].artist}",
                              style: ourTextStyle(
                                family: 'Barlow-Regular',
                                size: 12,
                              ),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: whiteColor,
                                size: 32,
                              ),
                            ),
                            trailing: controller.playIndex.value == index && controller.isPlaying.value ? const Icon(
                              Icons.play_arrow,
                              color: whiteColor,
                              size: 26,
                            ) : null,
                            onTap: (){
                              controller.playSong(snapshot.data![index].uri, index);
                              Get.to(()=> Player(data: snapshot.data!,));

                            },
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
    );
  }
}
