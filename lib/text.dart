import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main(List<String> args) async {
  var yt = YoutubeExplode();

  var manifest = await yt.videos.streamsClient.getManifest('cqP8I5aaud8');


  var streaminfo = manifest.audioOnly.withHighestBitrate();

  //var strrm = manifest.audio.first.url.toString();
   //var strma = manifest.audioOnly.first.url.toString();
   var  codec = manifest.audioOnly.withHighestBitrate().audioCodec.toString();

 var strma = manifest.audioOnly.withHighestBitrate().url.toString();

  print(strma);
   print(codec);



  // if(streaminfo != null){
  //   var stream = yt.videos.streamsClient.get(streaminfo);
  //   print(stream.first);
  //
  // }


  // Get highest quality muxed stream
//var streamInfo = manifest.muxed.withHigestVideoQuality();

// ...or highest bitrate audio-only stream
//var streamInfo = manifest.audioOnly.withHigestBitrate()

// ...or highest quality MP4 video-only stream
//var streamInfo.videoOnly.where((e) => e.container == Container)
}
