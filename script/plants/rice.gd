extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var grow_time
var amount
var base_grow_time
var plants_level = 1

func _ready() -> void:
	Global.all_stat_refresh.connect(plants_setting)
	plants_setting()

func plants_setting():
	grow_time = Global.gt_total_rice
	base_grow_time = grow_time
	amount = Global.fa_total_rice

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	base_grow_time -= delta
	if base_grow_time <= 0:
		plants_level = 4
	elif base_grow_time <= grow_time * 0.25:
		plants_level = 3
	elif base_grow_time <= grow_time * 0.5:
		plants_level = 2
	elif base_grow_time <= grow_time * 0.75:
		plants_level = 1
	plants_level_check()

func plants_level_check():
	match plants_level:
		1:
			animated_sprite_2d.play("1")
		2:
			animated_sprite_2d.play("2")
		3:
			animated_sprite_2d.play("3")
		4:
			animated_sprite_2d.play("4")
