extends Sprite2D

@export var candle_amount : int = 1
@onready var texture_ := texture
var broken_texture : Texture2D
var is_broken = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if candle_amount == 1:
		broken_texture = load("res://assets/candle_broken1.png")
	if candle_amount == 2:
		texture_ = load("res://assets/candle2.png")
		broken_texture = load("res://assets/candle_broken2.png")
	elif candle_amount == 3:
		texture_ = load("res://assets/candle3.png")
		broken_texture = load("res://assets/candle_broken3.png")
	elif candle_amount == 4:
		texture_ = load("res://assets/candle4.png")
		broken_texture = load("res://assets/candle_broken4.png")
	texture = texture_


func _on_candle_area_area_entered(area: Area2D) -> void:
	if is_broken:
		return
	if area.name == "cart_area" or area.name == "obstacle_area" or area.name == "player_area":
		texture = broken_texture
		is_broken = true
		$PointLight2D.enabled = false
		$candle_broke.play()
