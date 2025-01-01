extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_diaologue(timeline: String):
	$"../Player".set_physics_process(false)
	Dialogic.signal_event.connect(_on_dialog_signal)
	Dialogic.start(timeline)

func _on_dialog_signal(argument: String):
	if argument == "end":
		$"../Player".set_physics_process(true)
