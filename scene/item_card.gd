extends Button

@export var angle_x_max: float = 15.0
@export var angle_y_max: float = 15.0
@export var max_offset_shadow: float = 50.0

@export_category("Oscillator")
@export var spring: float = 150.0
@export var damp: float = 10.0
@export var velocity_multiplier: float = 2.0

var displacement: float = 0.0 
var oscillator_velocity: float = 0.0

var tween_rot: Tween
var tween_hover: Tween
var tween_destroy: Tween
var tween_handle: Tween

var last_mouse_pos: Vector2
var mouse_velocity: Vector2
var following_mouse: bool = false
var last_pos: Vector2
var velocity: Vector2

var slot_num: int
@onready var item_name: Label = $"SubViewportContainer/SubViewport/CardTexture/Control/item name"
@onready var item_image: TextureRect = $"SubViewportContainer/SubViewport/CardTexture/Control/item image"
@onready var item_discription: Label = $"SubViewportContainer/SubViewport/CardTexture/Control/item discription"
@onready var item_option: Label = $"SubViewportContainer/SubViewport/CardTexture/Control/item option"
@onready var animated_sprite_2d: AnimatedSprite2D = $SubViewportContainer/SubViewport/AnimatedSprite2D





@onready var card_texture: SubViewportContainer = $SubViewportContainer
var item_data
var mouse_followable = true

func _ready() -> void:
	spawn_tween()
	# Convert to radians because lerp_angle is using that
	angle_x_max = deg_to_rad(angle_x_max)
	angle_y_max = deg_to_rad(angle_y_max)

	# 머티리얼이 인스턴스 간에 공유되지 않도록 복제
	if card_texture.material:
		card_texture.material = card_texture.material.duplicate()



func _process(delta: float) -> void:

	rotate_velocity(delta)


func spawn_tween():
	var tween = create_tween()
	tween.tween_property(card_texture, "scale", Vector2(1,1), 0.25)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	
func set_item(item):
	item_name.text = str(item.item_name)
	item_discription.text = str(item.discription)
	item_option.text = str(item.item_option)
	item_data = item

func rotate_velocity(delta: float) -> void:
	if not mouse_followable: return
	if not following_mouse: return
	var center_pos: Vector2 = global_position - (size/2.0)
	print("Pos: ", center_pos)
	print("Pos: ", last_pos)
	# Compute the velocity
	velocity = (position - last_pos) / delta
	last_pos = position
	
	print("Velocity: ", velocity)
	oscillator_velocity += velocity.normalized().x * velocity_multiplier
	
	# Oscillator stuff
	var force = -spring * displacement - damp * oscillator_velocity
	oscillator_velocity += force * delta
	displacement += oscillator_velocity * delta
	
	rotation = displacement






func _on_gui_input(event: InputEvent) -> void:
	
	if not mouse_followable: return
	# Don't compute rotation when moving the card
	if following_mouse: return
	if not event is InputEventMouseMotion: return
	
	# Handles rotation
	# Get local mouse pos
	var mouse_pos: Vector2 = get_local_mouse_position()
	#print("Mouse: ", mouse_pos)
	#print("Card: ", position + size)
	var diff: Vector2 = (position + size) - mouse_pos

	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)
	#print("Lerp val x: ", lerp_val_x)
	#print("lerp val y: ", lerp_val_y)

	var rot_x: float = rad_to_deg(lerp_angle(-angle_x_max, angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	#print("Rot x: ", rot_x)
	#print("Rot y: ", rot_y)
	
	card_texture.material.set_shader_parameter("x_rot", rot_y)
	card_texture.material.set_shader_parameter("y_rot", rot_x)

func _on_mouse_entered() -> void:
	if not mouse_followable: return
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(1.2, 1.2), 0.5)

func _on_mouse_exited() -> void:
	if not mouse_followable: return
	# Reset rotation
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(card_texture.material, "shader_parameter/x_rot", 0.0, 0.5)
	tween_rot.tween_property(card_texture.material, "shader_parameter/y_rot", 0.0, 0.5)
	
	# Reset scale
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.55)

func reset_tilt() -> void:
	# 쉐이더 기울임 초기화
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(card_texture.material, "shader_parameter/x_rot", 0.0, 0.5)
	tween_rot.tween_property(card_texture.material, "shader_parameter/y_rot", 0.0, 0.5)

	# 스케일 초기화
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.55)

	# 오실레이터로 인한 회전(rotation) 초기화
	displacement = 0.0
	oscillator_velocity = 0.0
	rotation = 0.0

signal selected
func _on_pressed() -> void:
	selected.emit(slot_num)

func play_selected() -> void:
	if already_selected:
		return
	already_selected = true

	mouse_followable = false
	reset_tilt()
	selected_tween()
	Global.item_inventory.append(item_data)
	Global.apply_item(item_data.item_id)
	
	
signal disappeared
func selected_tween():
	# 1. 현재 화면상 위치를 먼저 저장
	var start_pos: Vector2 = card_texture.global_position

	# 2. top_level을 켜고
	card_texture.top_level = true

	# 3. 저장해둔 위치로 되돌림 → 화면상 위치 유지
	card_texture.global_position = start_pos

	card_texture.z_index += 50
	card_texture.pivot_offset = card_texture.size / 2.0

	var viewport_size: Vector2 = get_viewport_rect().size
	var center_pos: Vector2 = viewport_size / 2.0 - card_texture.size*1.5 / 2.0
	var exit_pos: Vector2 = Vector2(1620, 820) - card_texture.size / 4

	var tween = create_tween()
	var tween_scale = create_tween()

	tween.tween_property(card_texture, "global_position", center_pos, 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CIRC)
	tween_scale.tween_property(card_texture, "scale", Vector2(1.5,1.5), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CIRC)


	tween.tween_interval(1.5)
	tween_scale.tween_interval(1.5)

	tween.tween_property(card_texture, "global_position", exit_pos, 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CIRC)
	tween_scale.tween_property(card_texture, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CIRC)
	tween.tween_callback(func():disappeared.emit())


var already_selected = false
func cancel_selection():
	already_selected = true
	var tween = create_tween()
	tween.tween_property(card_texture, "scale", Vector2(0,0), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
