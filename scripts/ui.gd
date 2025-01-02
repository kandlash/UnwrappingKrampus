extends Control

@export var level_num : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$steps_label.text = "STEPS\n" + str(Globals.level_steps)
	$level_label.text =  "LEVEL\n" + str(level_num)

func update_steps():
	$steps_label.text = "STEPS\n" + str(Globals.level_steps)
