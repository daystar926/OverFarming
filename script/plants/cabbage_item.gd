extends Area2D

var life_time = 30
var is_level2_started = false
var is_level1_started = false
var is_level0_started = false
var blink_tween: Tween   # 깜빡임 트윈 추적용
var spawn_position: Vector2

# 20초 남으면 깜빡깜빡, 10초 남으면 더 빨리, 0초 지나면 천천히 사라짐
func _ready() -> void:
	if randi_range(1, 2) == 1:
		$AnimatedSprite2D.flip_h = true
	spawn_position_setting()
	start_tween()
	$AnimatedSprite2D.play("normal")
	
	
func spawn_position_setting():
	self.position = spawn_position

func _process(delta: float) -> void:
	pass

func hovering_tween():
	var current_pst = self.position
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position", current_pst + Vector2(0, 15), 0.6)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", current_pst, 0.6)
	tween.tween_interval(0.2)
	

func start_tween():
	var tween = Global.create_spawn_tween(self, 0.5, 0.7)
	tween.tween_callback(func(): $CollisionShape2D.disabled = false)
	tween.tween_callback(func(): hovering_tween())

func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	Global.stat_refresh()
	$CollisionShape2D.disabled = true
	set_process(false)
	$AnimatedSprite2D.play("suck")
	if blink_tween:
		blink_tween.kill()
	
	var tween = Global.create_collect_tween(self)
	tween.tween_callback(func():
		Global.add_gold(Global.fa_total_cabbage)
		queue_free()
	)
