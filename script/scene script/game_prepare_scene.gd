extends Control

@onready var character: AnimatedSprite2D = $character
@onready var left_arrow: TextureRect = $"arrows/left arrow"
@onready var right_arrow: TextureRect = $"arrows/right arrow"
@onready var title_label: Label = $title

@onready var left_arrow_button: TextureButton = $"arrows/left arrow/left arrow button"
@onready var right_arrow_button: TextureButton = $"arrows/right arrow/right arrow button"
@onready var back_button: Button = $"back button"
@onready var game_start_button: Button = $"game start button"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_tween()
	character_tween()
	left_arrow.pivot_offset = left_arrow.size / 2
	right_arrow.pivot_offset = right_arrow.size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	
	GlobalCanvas.white_transition("res://scene/major scene/main lobby.tscn")


func _on_left_arrow_button_pressed() -> void:
	left_arrow.scale = Vector2(1, 1)
	var tween = create_tween()
	tween.tween_property(left_arrow, "scale", Vector2(1.2, 0.8), 0.07)
	tween.tween_property(left_arrow, "scale", Vector2(1, 1), 0.07)


func _on_right_arrow_button_pressed() -> void:
	right_arrow.scale = Vector2(1, 1)
	var tween = create_tween()
	tween.tween_property(right_arrow, "scale", Vector2(1.2, 0.8), 0.07)
	tween.tween_property(right_arrow, "scale", Vector2(1, 1), 0.07)

func title_tween():
	var tween = create_tween()
	tween.tween_property(title_label, "position", Vector2(535, 34), 1)\
		.set_trans(Tween.TRANS_QUART)\
		.set_ease(Tween.EASE_OUT)

func character_tween():
	character.frame = 0
	var tween = create_tween()
	tween.tween_interval(0.7)
	tween.tween_property(character, "position", Vector2(964, 470), 0.3)
	tween.parallel().tween_property(character, "rotation", 0, 0.3)
	tween.tween_property(character, "position", Vector2(964, 450), 0.05)
	tween.tween_property(character, "position", Vector2(964, 470), 0.05)
	tween.tween_property(character, "position", Vector2(964, 465), 0.03)
	tween.tween_property(character, "position", Vector2(964, 470), 0.03)
	tween.tween_interval(0.7)
	tween.tween_callback(func():
		character.play("waking up")
		await character.animation_finished
		character.play("idle")
		button_unlock()
	)

func button_unlock():
	left_arrow_button.disabled = false
	game_start_button.disabled = false
	right_arrow_button.disabled = false
	back_button.disabled = false


func _on_game_start_button_pressed() -> void:
	GlobalCanvas.white_transition("res://scene/major scene/main_game.tscn")
