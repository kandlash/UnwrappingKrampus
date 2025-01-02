extends Node2D

@export var level_steps = 10
@export var level_carts = 2
@export var start_timeline: String = "None"
@export var end_timeline: String = "None"
@export var next_level : String
@export var level_num : int
# Called when the node enters the scene tree for the first time.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload"):
		reload_level()

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	Globals.level_carts = level_carts
	Globals.level_steps = level_steps
	$ui.update_steps()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if start_timeline != "None":
		$DialogueManager.play_diaologue(start_timeline)
	else:
		$Player.start_delay.start()

func update_steps():
	if Globals.level_steps - 1 > 0:
		Globals.level_steps -= 1
		$ui.update_steps()
	elif Globals.level_steps - 1 <= 0 and Globals.level_carts != 0:
		$Player.set_physics_process(false)
		Globals.level_steps -= 1
		if Globals.level_steps < 0:
			Globals.level_steps = 0
		$ui.update_steps()
		reload_level()

func reload_level():
	if not get_tree():
		return

	for node in get_children():
		node.set_process(false)
		node.set_physics_process(false)
	
	Transition.transition()
	await Transition.on_transition_finished
	
	if get_tree():
		get_tree().reload_current_scene()

func update_carts():
	if Globals.level_carts - 1 == 0:
		Globals.level_carts -= 1
		if end_timeline != "None":
			$Player.set_physics_process(false)
			set_process(false)
			$DialogueManager.play_diaologue(end_timeline)
		else:
			$StartLevelDelay.start()
			$Player.set_physics_process(false)
			set_process(false)
	else:
		Globals.level_carts -= 1

func start_next_level():
	set_process(false)
	WinSoundPlayer.play_sound()
	SuccessTransition.transition(level_num)
	await SuccessTransition.on_transition_finished
	get_tree().change_scene_to_file(next_level)

func _on_dialogic_signal(argument: String):
	if argument == "level_end":
		start_next_level()
	elif argument == "dialog_end":
		set_process(true)
		$Player.start_delay.start()


func _on_start_level_delay_timeout() -> void:
	start_next_level()
