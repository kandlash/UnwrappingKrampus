extends CanvasLayer

@export var level_num : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/steps_label.text = "STEPS\n" + str(Globals.level_steps)
	$Control/level_label.text =  "LEVEL\n" + str(level_num)

func update_steps():
	$Control/steps_label.text = "STEPS\n" + str(Globals.level_steps)
