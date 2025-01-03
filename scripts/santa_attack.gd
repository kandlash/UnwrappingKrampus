extends Node2D

var attack_sprite = load("res://assets/attack.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_prepare_attack_timer_timeout() -> void:
	$attack_area.monitorable = true
	$attack_area.monitoring = true
	$destroy_attack_timer.start()
	$attack_sprite.texture = attack_sprite


func _on_destroy_attack_timer_timeout() -> void:
	queue_free()
