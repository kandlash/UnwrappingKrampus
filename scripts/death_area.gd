extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.name == "player_area":
		var player = area.get_parent()
		var tween = create_tween()
		tween.tween_property(player,
		 "scale",
		 Vector2.ZERO,
		 0.3).set_trans(Tween.TRANS_SPRING)
		$"..".reload_level()
