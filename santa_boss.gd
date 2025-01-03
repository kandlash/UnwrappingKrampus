extends Node2D

var health = 150
@onready var attack_timer := $attack_timer
@export var time_min : float = 5.0
@export var time_max : float = 10.0
@export var min_attack: int = 1
@export var max_attack : int = 4
@export var attack : PackedScene
var can_attack = true
var start_position
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
	start_position = global_position


func reset_timer():
	randomize()
	attack_timer.wait_time = randf_range(time_min, time_max)
	attack_timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not can_attack:
		randomize()
		var random_x = randi_range(-1, 1)
		position += Vector2(random_x, 0)


func _on_santa_area_area_entered(area: Area2D) -> void:
	if area.name == "cart_area":
		var cart = area.get_parent()
		cart.end_cart_move()
		cart.queue_free()
		health -= 10
		$damage.play()
		get_parent().get_node("camera_catcher/Camera2D").set_shake(0.2)
		if health <= 0:
			can_attack = false
			$AnimationPlayer.play("death")

func _on_attack_timer_timeout() -> void:
	if not can_attack:
		return
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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		$Sprite2D.visible = false
		$Fuck.visible = true
		var tween = create_tween()
		tween.tween_property($Fuck, "global_position", start_position, 0.5).set_trans(Tween.TRANS_SPRING)
		$end_game_delay.start()


func _on_end_game_delay_timeout() -> void:
	get_parent().start_next_level()
