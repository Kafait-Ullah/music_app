import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/authorization/components/constants.dart';
import 'package:music_app/authorization/utils/player.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class MusicPage extends StatefulWidget {
  MusicPage({super.key, required this.songData});
  List<Map> songData;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  Stream<PositionData>? get _positionDataStream => audioPlayer == null
      ? null
      : Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer!.positionStream,
          audioPlayer!.bufferedPositionStream,
          audioPlayer!.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  List<AudioSource> srcs = [];

  @override
  void initState() {
    super.initState();
    srcs = widget.songData
        .map((e) => AudioSource.uri(
              Uri.parse(e['music_url']),
              tag: MediaItem(
                  id: UniqueKey().toString(),
                  artUri: Uri.parse(e["image_url"]),
                  title: e["song_name"] ?? "undefined"),
            ))
        .toList();

    getPlayer().setAudioSource(ConcatenatingAudioSource(children: srcs));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    MediaItem? currentSong = audioPlayer == null
        ? null
        : srcs[audioPlayer!.currentIndex ?? 0].sequence.first.tag;
    return Scaffold(
      body: currentSong == null
          ? CircularProgressIndicator()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.04,
                      left: size.width * 0.04,
                      right: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * 0.09,
                        width: size.width * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: size.height * 0.018,
                              color: Colors.black54,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: Text('Now playing',
                            style: TextStyle(
                                fontFamily: 'Font',
                                color: cblack,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05)),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: const Color(0xff7D7D7D),
                            size: size.width * 0.050,
                          ))
                    ],
                  ),
                ),
                Image.network(
                  currentSong.artUri.toString(),
                  height: 350,
                  width: 335,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(currentSong.title,
                        style: const TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    subtitle: Text(
                      currentSong.title,
                      style: const TextStyle(
                          fontFamily: 'Font', color: cblack, fontSize: 14),
                    ),
                    trailing: const Icon(FontAwesomeIcons.heart),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return ProgressBar(
                        barHeight: 2,
                        baseBarColor: Colors.grey,
                        progressBarColor: const Color(0xff434343),
                        thumbColor: const Color(0xff434343),

                        total: positionData?.duration ?? Duration.zero,
                        progress: positionData?.position ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        //to allow user to slide progress bar according to time
                        onSeek: audioPlayer!.seek,
                      );
                    },
                  ),
                ),
                Controls(audioPlayer: audioPlayer!),
              ],
            ),
    );
  }
}

//Custom class for storing multiple variables, storing for 3 different stream builders

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

//For start and stop a music
class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: audioPlayer.seekToPrevious,
            iconSize: 60,
            color: Colors.black,
            icon: const Icon(Icons.skip_previous)),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return Container(
                height: 100,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: cgreen),
                child: IconButton(
                    onPressed: audioPlayer.play,
                    iconSize: 60,
                    color: Colors.white,
                    icon: const Icon(Icons.play_arrow)),
              );
            } else if (processingState != ProcessingState.completed) {
              return Container(
                height: 100,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: cgreen),
                child: IconButton(
                    onPressed: audioPlayer.pause,
                    iconSize: 60,
                    color: Colors.white,
                    icon: const Icon(Icons.pause)),
              );
            }
            return Container(
              height: 100,
              decoration: BoxDecoration(shape: BoxShape.circle, color: cgreen),
              child: IconButton(
                  onPressed: audioPlayer.pause,
                  iconSize: 60,
                  color: Colors.white,
                  icon: const Icon(Icons.play_arrow_outlined)),
            );
          },
        ),
        IconButton(
            onPressed: audioPlayer.seekToNext,
            iconSize: 60,
            color: Colors.black,
            icon: const Icon(Icons.skip_next)),
      ],
    );
  }
}

















//Video Link to understand 
// https://youtu.be/DIqB8qEZW1U    