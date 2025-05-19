set("charset.encoding", "UTF-8")
settings.charset.max_string_length := 4096
set("decoder.ffmpeg.video_disable", true)

def smart_crossfade(source, fade_in, fade_out)
  crossfade(fade_in=fade_in, fade_out=fade_out, source)
end

radio_playlist = playlist(mode="normal", reload_mode="watch", "/home/music")
crossfaded = smart_crossfade(radio_playlist, 5.0, 5.0)
crossfaded = amplify(0.5, crossfaded)
radio = fallback(track_sensitive = false, [crossfaded, blank()])

output.icecast(%mp3,
  host = "host.docker.internal",
  port = 8000,
  password = "hackme",
  mount = "/radio.mp3",
  name = "ROARRadio",
  description = "O rugido do Leão que toca o coração",
  url = "https://roarradio.site",
  public = true,
  radio)
