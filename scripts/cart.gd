extends StaticBody2D

@export var facing_left_right = true
var can_be_moved = false
var direction := Vector2.ZERO
var tile_size = 16
var raydistance = 200
var on_boss = false
@onready var camera := $"../camera_catcher/Camera2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if facing_left_right:
		enable_left_right()
	else:
		enable_top_down()

func enable_left_right():
	$left_right.visible = true
	$top_down.visible = false
	$top_area.monitoring = false
	$down_area.monitoring = false
	$left_area.monitoring = true
	$right_area.monitoring = true
	$left_particle.emitting = true
	$right_particle.emitting = true
	$top_particle.emitting = false
	$down_particle.emitting = false
	$left_right_shadow.visible = true
	$top_down_shadow.visible = false
	
func enable_top_down():
	$left_right.visible = false
	$top_down.visible = true
	$top_area.monitoring = true
	$down_area.monitoring = true
	$left_area.monitoring = false
	$right_area.monitoring = false
	$left_particle.emitting = false
	$right_particle.emitting = false
	$top_particle.emitting = true
	$down_particle.emitting = true
	$left_right_shadow.visible = false
	$top_down_shadow.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not can_be_moved:
		return
		
	if Input.is_action_just_pressed("move_up") and direction == Vector2.UP:
		move()
	elif Input.is_action_just_pressed("move_down") and direction == Vector2.DOWN:
		move()
	elif Input.is_action_just_pressed("move_left") and direction == Vector2.LEFT:
		move()
	elif Input.is_action_just_pressed("move_right") and direction == Vector2.RIGHT:
		move()

func move():

	var distance = 0
	$RayCast2D.target_position = direction * raydistance
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		distance = position.distance_to($RayCast2D.get_collision_point())
	if distance < tile_size:
		$damage.pitch_scale = 0.7
		$damage.play()
		camera.set_shake(0.08)
		return
	can_be_moved = false
	$damage.pitch_scale = 1
	$damage.play()
	camera.set_shake(0.1)
	get_parent().get_node("Player").set_physics_process(false)
	var coof = round(distance/tile_size)-1
	var tween = create_tween()
	tween.tween_property(
	self,
	"position",
	position + direction * tile_size * coof,
	0.2*coof/1.5
	).set_trans(Tween.TRANS_SPRING)
	tween.tween_callback(end_cart_move)

func end_cart_move():
	$cart_stop.play()
	camera.set_shake(0.15)
	get_parent().get_node("Player").set_physics_process(true)
	if not on_boss:
		get_parent().update_steps()
	
	if facing_left_right:
		enable_top_down()
		facing_left_right = false
	else:
		facing_left_right = true
		enable_left_right()

func _on_top_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		direction = Vector2(0, 1)
		can_be_moved = true
		ensure_unique_material($top_down)
		$top_down.material.set_shader_parameter("line_thickness", 0.5)


func _on_top_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		ensure_unique_material($top_down)
		$top_down.material.set_shader_parameter("line_thickness", 0)


func _on_down_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = true
		direction = Vector2(0, -1)
		ensure_unique_material($top_down)
		$top_down.material.set_shader_parameter("line_thickness", 0.5)


func _on_down_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		ensure_unique_material($top_down)
		$top_down.material.set_shader_parameter("line_thickness", 0)


func _on_left_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = true
		direction = Vector2(1, 0)
		ensure_unique_material($left_right)
		$left_right.material.set_shader_parameter("line_thickness", 0.5)


func _on_left_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		ensure_unique_material($left_right)
		$left_right.material.set_shader_parameter("line_thickness", 0)


func _on_right_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = true
		direction = Vector2(-1, 0)
		ensure_unique_material($left_right)
		$left_right.material.set_shader_parameter("line_thickness", 0.5)


func _on_right_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		ensure_unique_material($left_right)
		$left_right.material.set_shader_parameter("line_thickness", 0)



func ensure_unique_material(sprite: Sprite2D) -> void:
	if sprite.material is ShaderMaterial and sprite.material.resource_local_to_scene == false:
		sprite.material = sprite.material.duplicate()
		sprite.material.resource_local_to_scene = true
