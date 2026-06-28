extends CharacterBody2D

@export var speed: float = Global.total_move_speed

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var field_collision: CollisionShape2D = $"field collision area2d/get collision"
@onready var yield_collision: CollisionShape2D = $"yield collision/CollisionShape2D"

var last_direction: String = "down"

func _ready() -> void:
	Global.all_stat_refresh.connect(update_stat)

func _process(delta: float) -> void:
	field_collision.disabled = not Input.is_key_pressed(KEY_SHIFT)
	yield_collision.disabled = not Input.is_key_pressed(KEY_SPACE)
func update_stat():
	speed = Global.total_move_speed

func _physics_process(delta: float) -> void:
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
