extends Node2D

@export var level_steps = 10
@export var level_carts = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.level_carts = level_carts
	Globals.level_steps = level_steps
	$ui.update_steps()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	$Player.set_physics_process(false)
	Dialogic.start("test_timeline")

func update_steps():
	if Globals.level_steps - 1 >= 0:
		Globals.level_steps -= 1
	else:
		print('loose!')
	$ui.update_steps()

func update_carts():
	if Globals.level_carts - 1 == 0:
		print('win!')
	else:
		Globals.level_carts -= 1


func _on_dialogic_signal(argument: String):
	if argument == "end":
		$Player.set_physics_process(true)
