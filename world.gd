extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	$Player.set_physics_process(false)
	Dialogic.start("timeline")

func _on_dialogic_signal(argument: String):
	if argument == "end":
		$Player.set_physics_process(true)
