extends CanvasLayer

@onready var main_character: CharacterBody2D = $"../Main Character"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var rice = preload("res://scene/plants/rice.tscn").instantiate()
	main_character.add_child(rice)

var current_time_scale = 1
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("speed_up"):
		if current_time_scale >= 3:
			return
		current_time_scale += 1
		engine_speed_setting()
	elif Input.is_action_just_pressed("speed_down"):
		if current_time_scale <= 1:
			return
		current_time_scale -= 1
		engine_speed_setting()
			
func engine_speed_setting():
	Engine.time_scale = current_time_scale
