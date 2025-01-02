extends CharacterBody2D


const SPEED = 300.0
const step_size = 16
var is_moving = false
var tile_size = 16
var particles_rotation = 0
@onready var start_delay := $start_delay

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	if Input.is_action_just_pressed("move_up"):
		direction.y = -1
		particles_rotation = 90
		move(direction)
	elif Input.is_action_just_pressed("move_down"):
		direction.y = 1
		particles_rotation = 270
		move(direction)
	elif Input.is_action_just_pressed("move_left"):
		direction.x = -1
		particles_rotation = 0
		move(direction)
	elif Input.is_action_just_pressed("move_right"):
		direction.x = 1
		particles_rotation = 180
		move(direction)

func move(direction: Vector2):
	if is_moving and direction != Vector2.ZERO:
		return
		
	$RayCast2D.target_position = direction * tile_size
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		return 
	is_moving = true
	get_parent().update_steps()
	var tween = create_tween()
	tween.tween_property(self,
	 "position",
	 position + direction * tile_size,
	 0.15
	).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(set_move_false)
	
func snap_to_grid():
	position.x = round(position.x)
	position.y = round(position.y)

func set_move_false():
	is_moving = false
	snap_to_grid()


func _on_start_delay_timeout() -> void:
	set_physics_process(true)
