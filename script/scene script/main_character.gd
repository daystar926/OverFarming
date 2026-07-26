extends CharacterBody2D
@onready var camera_2d: Camera2D = $Camera2D

@export var speed: float = Global.total_move_speed

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var field_collision: CollisionShape2D = $"field collision area2d/get collision"
@onready var yield_collision: CollisionShape2D = $"yield collision/CollisionShape2D"
@onready var remove_collision: CollisionShape2D = $"remove plant/CollisionShape2D"

var last_direction: String = "down"

func _ready() -> void:
	Global.stat_refresh()
	update_stat()
	skin_change()
	Global.all_stat_refresh.connect(update_stat)
	Global.time_stop_signal.connect(character_stop)
	Global.time_start_signal.connect(character_start)
	Global.cry_signal.connect(character_cry)
	Global.skin_change_signal.connect(skin_change_mode)
	Global.skin_change_finishignal.connect(skin_change_mode_exit)
	Global.start_item_change_signal.connect(skin_change)
	
	
var is_movable = true

func zoom_for_ch():
	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(3, 3), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(camera_2d, "position", Vector2(0, -30), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_callback(func(): animated_sprite.play("sleeping"))
	tween.tween_interval(2)
	tween.tween_property(camera_2d, "zoom", Vector2(0.9, 0.9), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(camera_2d, "position", Vector2(0, 0), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	await tween.finished
	
func character_stop():
	is_movable = false

	animated_sprite.play("idle")
	
func character_start():
	is_movable = true

func character_cry():
	animated_sprite.play("crying")

func _process(delta: float) -> void:
	if is_movable:
		field_collision.disabled = not Input.is_key_pressed(KEY_SHIFT)
		yield_collision.disabled = not Input.is_key_pressed(KEY_SPACE)
		remove_collision.disabled = not Input.is_key_pressed(KEY_Q)

func update_stat():
	speed = Global.total_move_speed
	print(speed)
	
func _physics_process(delta: float) -> void:
	if is_movable:
		var input_vector := Vector2.ZERO

		input_vector.x = Input.get_axis("ui_left", "ui_right")
		input_vector.y = Input.get_axis("ui_up", "ui_down")
		input_vector = input_vector.normalized()

		velocity = input_vector * speed
		move_and_slide()

		update_animation(input_vector)



func update_animation(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		animated_sprite.play("idle")
		return

	if input_vector.x != 0:
		animated_sprite.play("walk right")
		animated_sprite.flip_h = input_vector.x < 0
	else:
		if input_vector.y < 0:
			animated_sprite.play("walk up")
		else:
			animated_sprite.play("walk down")
		animated_sprite.flip_h = false

func skin_change_mode():
	is_movable = false
	animated_sprite.play("idle")
	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(3, 3), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(camera_2d, "position", Vector2(0, -30), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
		
func skin_change_mode_exit():
	is_movable = true
	animated_sprite.play("idle")
	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(0.9, 0.9), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(camera_2d, "position", Vector2(0, -30), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)

func skin_change():
	var path = Global.start_item_list[Global.start_item]
	animated_sprite.sprite_frames = load(path)
	animated_sprite.play("idle")
