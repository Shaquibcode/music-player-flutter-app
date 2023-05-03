import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:muzic/const/colors.dart';
import 'package:muzic/const/textStyle.dart';
import 'package:muzic/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel>data;
  const Player({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerController controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Column(
        children: [
          Obx(
          ()=> Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
                width: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: QueryArtworkWidget(
                  id: data[controller.playIndex.value].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    color: whiteColor,
                    size: 54,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                color: whiteColor,
              ),
              child: Obx(
    ()=> Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                    data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourTextStyle(
                          color: bgDarkColor, family: 'Barlow-Bold', size: 24),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourTextStyle(
                          color: bgDarkColor, family: 'Barlow-Regular', size: 20),
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: ourTextStyle(color: bgDarkColor),
                          ),
                          Expanded(
                            child: Slider(
                              thumbColor: sliderColor,
                              activeColor: sliderColor,
                              inactiveColor: bgColor,
                              value: controller.value.value,
                              min: const  Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              onChanged: (newValue) {
                                controller.changeDurationToSeconds(newValue);
                                newValue = newValue;
                              },
                            ),
                          ),
                          Text(
                            controller.duration.value,
                            style: ourTextStyle(color: bgDarkColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.playSong(data[controller.playIndex.value].uri, controller.playIndex.value-1);
                          },
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                            color: bgDarkColor,
                          ),
                        ),
                        Obx(
                          () => CircleAvatar(
                            radius: 35,
                            backgroundColor: bgDarkColor,
                            child: Transform.scale(
                              scale: 2.5,
                              child: IconButton(
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying.value = false;
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying.value = true;
                                  }
                                },
                                icon: controller.isPlaying.value
                                    ? const Icon(
                                        Icons.pause,
                                        color: whiteColor,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                        color: whiteColor,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.playSong(data[controller.playIndex.value].uri, controller.playIndex.value+1);
                          },
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                            color: bgDarkColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
