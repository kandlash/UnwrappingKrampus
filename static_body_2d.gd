extends StaticBody2D

@export var facing_left_right = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if facing_left_right:
		$left_right.visible = true
		$top_down.visible = false
	else:
		$left_right.visible = false
		$top_down.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
