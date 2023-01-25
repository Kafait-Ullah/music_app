import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

AudioPlayer? audioPlayer;

AudioPlayer getPlayer() {
  if (audioPlayer == null) {
    audioPlayer = AudioPlayer();
    return audioPlayer!;
  } else {
    return audioPlayer!;
  }
}

