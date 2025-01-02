extends StaticBody2D

@export var access_direction := Vector2(1, 0)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name != "cart_area":
		return
	var cart = area.get_parent()
	if cart.direction != access_direction:
		return
	get_parent().update_carts()
	$PointLight2D.enabled = false
	$CPUParticles2D.emitting = false
	$shadow.visible = false
	var tween = create_tween()
	tween.tween_property(cart,
	 "position",
	 position + cart.direction * 8,
	 0.3
	).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(cart,
	 "scale",
	 Vector2.ZERO,
	 0.5
	).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_callback(cart.queue_free)
