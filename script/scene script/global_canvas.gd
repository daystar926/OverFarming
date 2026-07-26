extends CanvasLayer

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var alert_1_texture: TextureRect = $"alert 1 texture"
## 소프트웨어 마우스 커서 (idle / click 2종)

@export var hotspot: Vector2 = Vector2(4, 2)

## 클릭 시 눌리는 크기 비율
@export var punch_scale: float = 0.82
## 눌리는 시간
@export var punch_in_time: float = 0.05
## 되돌아오는 시간
@export var punch_out_time: float = 0.14

@onready var sprite: AnimatedSprite2D = $cursor


var _base_scale: Vector2 = Vector2.ONE
var _tween: Tween = null
var _enabled: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	layer = 128
	follow_viewport_enabled = false
	process_mode = Node.PROCESS_MODE_ALWAYS

	sprite.centered = false
	sprite.offset = -hotspot
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_base_scale = sprite.scale

	set_process_input(false)
	hide()
	enable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func white_transition(path):

	
	animated_sprite_2d.play("open")
	AudioManager.play_sfx("transition", 0.2)
	await animated_sprite_2d.animation_finished
	
	get_tree().change_scene_to_file(path)
	await get_tree().tree_changed
	AudioManager.play_sfx("transition", 0.2)
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








## ---------------------------------------------------------------- 공개 API

func enable() -> void:
	if _enabled:
		return
	_enabled = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	sprite.position = get_viewport().get_mouse_position()
	sprite.scale = _base_scale
	sprite.play("idle")
	show()
	set_process_input(true)


func disable() -> void:
	if not _enabled:
		return
	_enabled = false
	_kill_tween()
	sprite.scale = _base_scale
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	hide()
	set_process_input(false)


## ---------------------------------------------------------------- 입력

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite.position = (event as InputEventMouseMotion).position
		return

	if event is InputEventMouseButton:
		var button_event: InputEventMouseButton = event as InputEventMouseButton
		if button_event.button_index != MOUSE_BUTTON_LEFT:
			return
		if button_event.pressed:
			_on_pressed()
		else:
			_on_released()


func _on_pressed() -> void:
	_play_safe("click")
	_punch()


func _on_released() -> void:
	_play_safe("idle")


## ---------------------------------------------------------------- 연출

func _punch() -> void:
	_kill_tween()

	_tween = create_tween()
	_tween.set_ignore_time_scale(true)

	_tween.tween_property(sprite, "scale", Vector2(3, 3), 0.1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	_tween.tween_property(sprite, "scale", Vector2(3.5, 3.5), 0.1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)

func _kill_tween() -> void:
	if _tween != null and _tween.is_valid():
		_tween.kill()
	_tween = null


func _play_safe(anim_name: String) -> void:
	if sprite.sprite_frames == null:
		return
	if not sprite.sprite_frames.has_animation(anim_name):
		return
	if sprite.animation != anim_name:
		sprite.play(anim_name)


## ---------------------------------------------------------------- 창 포커스

func _notification(what: int) -> void:
	if not _enabled:
		return
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif what == NOTIFICATION_APPLICATION_FOCUS_IN:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
