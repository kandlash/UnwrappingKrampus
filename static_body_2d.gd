extends StaticBody2D

@export var facing_left_right = true
var can_be_moved = false
var direction := Vector2.ZERO
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

func enable_top_down():
	$left_right.visible = false
	$top_down.visible = true
	$top_area.monitoring = true
	$down_area.monitoring = true
	$left_area.monitoring = false
	$right_area.monitoring = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action") and can_be_moved:
		print('moving!')
		move()

func move():
	var tween = create_tween()
	tween.tween_property(self, "position", position + direction * 50, 0.3)

func _on_top_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		direction = Vector2(0, 1)
		can_be_moved = true


func _on_top_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		direction = Vector2.ZERO


func _on_down_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = true
		direction = Vector2(0, -1)


func _on_down_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		direction = Vector2.ZERO


func _on_left_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = true
		direction = Vector2(1, 0)


func _on_left_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		direction = Vector2.ZERO


func _on_right_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = true
		direction = Vector2(-1, 0)


func _on_right_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_be_moved = false
		direction = Vector2.ZERO
