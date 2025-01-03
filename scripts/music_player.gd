extends Node


func play_music():
	if not $MusicPlayer.playing:
		$MusicPlayer.play()

func play_boss_music():
	if $MusicPlayer.playing:
		$MusicPlayer.stop()
	$MusicPlayer.stream = load("res://assets/audio/!$not dead yet.mp3")
	$MusicPlayer.play()
