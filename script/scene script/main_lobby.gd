extends Control

@onready var buttons: Control = $buttons

@onready var animation_player: AnimationPlayer = $background/AnimationPlayer

@onready var back_ground: TextureRect = $"background/back ground"
@onready var front_ground: TextureRect = $"background/front ground"
@onready var cloud: TextureRect = $background/cloud
@onready var cloud_2: TextureRect = $"background/cloud 2"

@onready var logo_cloud: TextureRect = $"logo/logo cloud"
@onready var logo_farming: TextureRect = $"logo/logo farming"
@onready var logo_over: TextureRect = $"logo/logo over"
@onready var logo_items: TextureRect = $"logo/logo items"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_tween()
	first_anim_tween()
	first_logo_anim()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func first_anim_tween():
	var tween = create_tween()
	tween.tween_property(cloud, "position", Vector2(195, -400), 2)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(cloud_2, "position", Vector2(0, -400), 2)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.5)
	
	tween.parallel().tween_property(back_ground, "position", Vector2(-243, -100), 2)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.9)
	tween.parallel().tween_property(front_ground, "position", Vector2(-183, -100), 2)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.9)
	tween.tween_callback(func():animation_player.play("cloud anim"))
func first_logo_anim():
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_property(logo_cloud, "position", Vector2(467, 0), 1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(logo_farming, "position", Vector2(467, 0), 1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_delay(0.2)
	tween.parallel().tween_property(logo_over, "position", Vector2(467, 0), 1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_delay(0.4)
	tween.parallel().tween_property(logo_items, "scale", Vector2(4, 4), 1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_delay(1.4)

func button_tween():
	var tween = create_tween()
	tween.tween_property(buttons, "position", Vector2(0,0), 1.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(3)

func button_close_tween():
	$"buttons/game start".disabled = true
	$buttons/VBoxContainer/option.disabled = true
	$buttons/VBoxContainer/discord.disabled = true
	$buttons/VBoxContainer/exit.disabled = true
	
	var tween = create_tween()
	tween.parallel().tween_property(buttons, "position", Vector2(1000,0), 1)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	tween.tween_interval(2.5)
	tween.tween_callback(func():
		GlobalCanvas.white_transition("res://scene/major scene/game_prepare_scene.tscn"))


func _on_game_start_pressed() -> void:
	button_close_tween()


func _on_exit_pressed() -> void:
	get_tree().quit()
