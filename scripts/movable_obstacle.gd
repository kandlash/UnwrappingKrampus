extends StaticBody2D

var move_direction := Vector2.ZERO
@export var tile_size = 16
@export var step_coof = 1
var step : int
var can_be_moved = false
@onready var raycast := $RayCast2D
@onready var camera := $"../Camera2D"

func _ready() -> void:
	step = tile_size * step_coof

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action") and can_be_moved:
		move()
	
func move():
	camera.set_shake(0.1)
	var level = get_parent()
	var player = level.get_node("Player")
	player.set_physics_process(false)
	Globals.level_steps -= 1
	level.update_steps()
	
	var tween = create_tween()
	tween.tween_property(self,
	 "position",
	 position + move_direction,
	 0.15).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(end_move)

func end_move():
	camera.set_shake(0.1)
	var player = get_parent().get_node("Player")
	player.set_physics_process(true)

func try_access_move(direction):
	raycast.target_position = direction
	raycast.force_raycast_update()
	if raycast.is_colliding():
		return
	can_be_moved = true
	move_direction = direction

func _on_top_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		try_access_move(Vector2(0, step))

func _on_top_area_body_exited(body: Node2D) -> void:
	can_be_moved = false


func _on_down_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		try_access_move(Vector2(0, -step))


func _on_down_area_body_exited(body: Node2D) -> void:
	can_be_moved = false


func _on_left_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		try_access_move(Vector2(step, 0))

func _on_left_area_body_exited(body: Node2D) -> void:
	can_be_moved = false


func _on_right_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		try_access_move(Vector2(-step, 0))

func _on_right_area_body_exited(body: Node2D) -> void:
	can_be_moved = false
