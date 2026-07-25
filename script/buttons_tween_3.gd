extends Control



func _on_mouse_entered() -> void:


	self.scale = Vector2(1, 1)
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(self, "scale", Vector2(0.95 , 1.1), 0.07)
	tween.tween_property(self, "scale", Vector2(0.97, 1.05), 0.07)
	


func _on_mouse_exited() -> void:

	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(self, "scale", Vector2(1.05 , 0.9), 0.07)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.07)
	


func _on_pressed() -> void:
	self.scale = Vector2(1, 1)
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(self, "scale", Vector2(0.95 , 1.1), 0.07)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.07)
