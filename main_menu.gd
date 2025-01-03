extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reload_level():
	if not get_tree():
		return
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/levels/train_level_1.tscn")

func _on_play_bt_pressed() -> void:
	$press_player.play()
	reload_level()
	


func _on_exit_bt_pressed() -> void:
	$press_player.play()
	$exit_delay.start()


func _on_exit_delay_timeout() -> void:
	get_tree().quit()


func _on_play_bt_mouse_entered() -> void:
	$hover_player.play()


func _on_exit_bt_mouse_entered() -> void:
	$hover_player.play()
