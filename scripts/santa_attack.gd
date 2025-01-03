extends Node2D

var attack_sprite = load("res://assets/attack.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$prepare_attack_sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_prepare_attack_timer_timeout() -> void:
	get_parent().get_node("camera_catcher/Camera2D").set_shake(0.1)
	$attack_area.monitorable = true
	$attack_area.monitoring = true
	$destroy_attack_timer.start()
	$attack_sprite.texture = attack_sprite
	$predict_light.enabled = false
	$attack_light.enabled = true
	$attack_sound.play()

func _on_destroy_attack_timer_timeout() -> void:
	queue_free()
