extends Node2D

@export var cart_scene : PackedScene
@export var time_min : float = 5.0
@export var time_max : float = 15.0
var can_spawn = false
@onready var spawn_delay_timer = $spawn_delay
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_timer()


func reset_timer():
	randomize()
	spawn_delay_timer.wait_time = randf_range(time_min, time_max)
	spawn_delay_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_delay_timeout() -> void:
	var cart = cart_scene.instantiate()
	cart.position = position
	randomize()
	var chance = randi_range(0, 100)
	if  chance <= 10:
		cart.facing_left_right = true
	else:
		cart.facing_left_right = false
	get_parent().add_child(cart)
	reset_timer()
	
