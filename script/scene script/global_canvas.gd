extends CanvasLayer

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var alert_1_texture: TextureRect = $"alert 1 texture"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func white_transition(path):

	
	animated_sprite_2d.play("open")
	await animated_sprite_2d.animation_finished
	
	get_tree().change_scene_to_file(path)
	await get_tree().tree_changed
	
	animated_sprite_2d.play("close")

var alert_1_tween: Tween
func dev_alert_1():
	if alert_1_tween:
		alert_1_tween.kill()

	alert_1_tween = alert_1_texture.create_tween()
	alert_1_tween.set_ignore_time_scale(true)
	alert_1_tween.tween_property(alert_1_texture, "position", Vector2(680, 0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	alert_1_tween.tween_interval(1.5)
	alert_1_tween.tween_property(alert_1_texture, "position", Vector2(680, -250), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
