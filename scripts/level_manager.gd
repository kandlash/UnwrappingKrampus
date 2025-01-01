extends Node2D

@export var level_steps = 10
@export var level_carts = 2
@export var start_timeline: String = "None"
@export var end_timeline: String = "None"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.level_carts = level_carts
	Globals.level_steps = level_steps
	$ui.update_steps()
	if start_timeline != "None":
		$DialogueManager.play_diaologue(start_timeline)

func update_steps():
	if Globals.level_steps - 1 >= 0:
		Globals.level_steps -= 1
	else:
		print('loose!')
	$ui.update_steps()

func update_carts():
	if Globals.level_carts - 1 == 0:
		if end_timeline != "None":
			$DialogueManager.play_diaologue(end_timeline)
	else:
		Globals.level_carts -= 1


func _on_dialogic_signal(argument: String):
	if argument == "end":
		$Player.set_physics_process(true)
