extends Node2D

@export var level_steps = 10
@export var level_carts = 2
@export var start_timeline: String = "None"
@export var end_timeline: String = "None"
@export var next_level : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.level_carts = level_carts
	Globals.level_steps = level_steps
	$ui.update_steps()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if start_timeline != "None":
		$DialogueManager.play_diaologue(start_timeline)

func update_steps():
	if Globals.level_steps - 1 > 0:
		Globals.level_steps -= 1
		$ui.update_steps()
	elif Globals.level_steps - 1 <= 0 and Globals.level_carts != 0:
		$Player.set_physics_process(false)
		Globals.level_steps -= 1
		$ui.update_steps()
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().reload_current_scene()

func update_carts():
	if Globals.level_carts - 1 == 0:
		Globals.level_carts -= 1
		if end_timeline != "None":
			$Player.set_physics_process(false)
			$DialogueManager.play_diaologue(end_timeline)
	else:
		Globals.level_carts -= 1


func _on_dialogic_signal(argument: String):
	if argument == "end":
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file(next_level)
