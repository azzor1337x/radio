settings.charset.max_string_length := 4096
set("decoder.ffmpeg.video_disable", true)
radio_playlist = playlist(mode="normal", reload_mode="watch", "/home/music/*.mp3")
crossfaded = crossfade(fade_in=5.0, fade_out=5.0, radio_playlist)
crossfaded = amplify(0.5, crossfaded)
radio = fallback(track_sensitive = false, [crossfaded, blank()])
output.icecast(%mp3,
  host = "host.docker.internal",
  port = 8000,
  password = "hackme",
  mount = "/radio.mp3",
  name = "ROARRadio",
  description = "O rugido do Leao que toca o coracao",
  url = "https://roarradio.site",
  public = true,
  radio)
