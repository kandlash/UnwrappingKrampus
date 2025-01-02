extends CanvasLayer

#func _process(delta: float) -> void:
	#$Control/FPS_LABEL.text = str(Engine.get_frames_per_second())

func play_animation(text: String):
	$Control/RichTextLabel.text = text
	$AnimationPlayer.play("text_moving")
