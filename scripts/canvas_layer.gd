extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.visible = false
	anim_player.animation_finished.connect(_on_anim_finished)

func _on_anim_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		anim_player.play("fade_to_normal")
		
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
	
func transition():
	color_rect.visible = true
	anim_player.play("fade_to_black")
