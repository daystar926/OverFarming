extends Control

@onready var buttons: Control = $buttons
@onready var title_label: Label = $title

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_tween()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func button_tween():
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_property(title_label, "position", Vector2(293,50), 1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(buttons, "position", Vector2(0,0), 1.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)

func button_close_tween():
	$"buttons/game start".disabled = true
	$buttons/VBoxContainer/option.disabled = true
	$buttons/VBoxContainer/discord.disabled = true
	$buttons/VBoxContainer/exit.disabled = true
	
	var tween = create_tween()
	tween.tween_property(title_label, "position", Vector2(293,-200), 1)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(buttons, "position", Vector2(1000,0), 1)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	tween.tween_interval(2.5)
	tween.tween_callback(func(): GlobalCanvas.white_transition("res://scene/major scene/game_prepare_scene.tscn"))


func _on_game_start_pressed() -> void:
	button_close_tween()


func _on_exit_pressed() -> void:
	get_tree().quit()
