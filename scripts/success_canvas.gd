extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var anim_player = $AnimationPlayer
@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.visible = false
	label.visible = false
	anim_player.animation_finished.connect(_on_anim_finished)

func _on_anim_finished(anim_name):
	if anim_name == "win_fade_in":
		on_transition_finished.emit()
		anim_player.play("win_fade_out")
		
	elif anim_name == "win_fade_out":
		color_rect.visible = false
		label.visible = false
	
func transition(level_num: int):
	color_rect.visible = true
	label.visible = true
	label.text = "SUCCESS\nLEVEL " + str(level_num)
	anim_player.play("win_fade_in")
