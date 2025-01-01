extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$steps_label.text = "STEPS\n" + str(Globals.level_steps)


func update_steps():
	$steps_label.text = "STEPS\n" + str(Globals.level_steps)
