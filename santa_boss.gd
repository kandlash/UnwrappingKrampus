extends Node2D

var health = 120
@onready var attack_timer := $attack_timer
@export var time_min : float = 5.0
@export var time_max : float = 10.0
@export var min_attack: int = 1
@export var max_attack : int = 4
@export var attack : PackedScene

@onready var attack_positions = [
	$attack_position,
	$attack_position2,
	$attack_position3,
	$attack_position4,
	$attack_position5,
	$attack_position6,
	$attack_position7,
	$attack_position8,
	$attack_position9,
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_timer()


func reset_timer():
	randomize()
	attack_timer.wait_time = randf_range(time_min, time_max)
	attack_timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_santa_area_area_entered(area: Area2D) -> void:
	if area.name == "cart_area":
		var cart = area.get_parent()
		cart.end_cart_move()
		cart.queue_free()
		health -= 50
		$damage.play()
		get_parent().get_node("camera_catcher/Camera2D").set_shake(0.2)
		if health <= 0:
			print('santa is dead')


func _on_attack_timer_timeout() -> void:
	randomize()
	var indexes = []
	var attacks_count = randi_range(min_attack, max_attack)
	while attacks_count > 0:
		var choice = randi_range(0, len(attack_positions)-1)
		if choice not in indexes:
			indexes.append(choice)
			attacks_count-=1
			
	for i in indexes:
		var new_attack = attack.instantiate()
		new_attack.position = attack_positions[i].global_position
		get_parent().add_child(new_attack)
	reset_timer()
