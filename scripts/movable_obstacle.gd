extends StaticBody2D

var move_direction := Vector2.ZERO
@export var tile_size = 16
@export var step_coof = 1
var step : int
var direction := Vector2.ZERO
var can_be_moved = false
@onready var raycast := $RayCast2D
@onready var camera := $"../Camera2D"

func _ready() -> void:
	step = tile_size * step_coof
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up") and direction == Vector2.UP:
		if check_can_move():
			move()
	elif Input.is_action_just_pressed("move_down") and direction == Vector2.DOWN:
		if check_can_move():
			move()
	elif Input.is_action_just_pressed("move_left") and direction == Vector2.LEFT:
		if check_can_move():
			move()
	elif Input.is_action_just_pressed("move_right") and direction == Vector2.RIGHT:
		if check_can_move():
			move()

func check_can_move():
	if not can_be_moved:
		camera.set_shake(0.08)
		$damage.pitch_scale = 0.7
		$damage.play()
		return false
	return true

func move():
	$damage.pitch_scale = 1
	$damage.play()
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
	$damage.pitch_scale = 0.8
	$damage.play()
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
		set_process(true)
		try_access_move(Vector2(0, step))
		direction = Vector2(0, 1)
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0.5)

func _on_top_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		set_process(false)
		can_be_moved = false
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)


func _on_down_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)
		direction = Vector2(0, -1)
		try_access_move(Vector2(0, -step))
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0.5)


func _on_down_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		set_process(false)
		can_be_moved = false
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)


func _on_left_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)
		direction = Vector2(1, 0)
		try_access_move(Vector2(step, 0))
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0.5)

func _on_left_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		set_process(false)
		can_be_moved = false
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)


func _on_right_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)
		direction = Vector2(-1, 0)
		try_access_move(Vector2(-step, 0))
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0.5)

func _on_right_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		set_process(false)
		can_be_moved = false
		ensure_unique_material($Sprite2D)
		$Sprite2D.material.set_shader_parameter("line_thickness", 0)
		
func ensure_unique_material(sprite: Sprite2D) -> void:
	if sprite.material is ShaderMaterial and sprite.material.resource_local_to_scene == false:
		sprite.material = sprite.material.duplicate()
		sprite.material.resource_local_to_scene = true
