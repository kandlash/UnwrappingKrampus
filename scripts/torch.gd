extends Sprite2D

@onready var broken_texture = load("res://assets/torch/broken_torch.png")
var is_broken = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func broke_torch():
	is_broken = true
	texture = broken_texture
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.visible = false
	$PointLight2D.enabled = false
	$wood_broke_player.play()
	$extinguished_player.play()

func _on_broke_area_area_entered(area: Area2D) -> void:
	if is_broken:
		return
	if area.name == "cart_area" or area.name == "obstacle_area" or area.name == "player_area":
		broke_torch()
