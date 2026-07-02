extends Area2D

var life_time = 30
var is_level2_started = false
var is_level1_started = false
var is_level0_started = false
var blink_tween: Tween   # 깜빡임 트윈 추적용
var spawn_position: Vector2

# 20초 남으면 깜빡깜빡, 10초 남으면 더 빨리, 0초 지나면 천천히 사라짐
func _ready() -> void:
	spawn_position_setting()
	start_tween()
	
	
func spawn_position_setting():
	self.position = spawn_position

func _process(delta: float) -> void:
	life_time -= delta
	# 0 이하 → 10 이하 → 20 이하 순으로 검사 (가장 급한 것부터, elif로 한 번에 하나만)
	if life_time <= 0:
		if not is_level0_started:
			life_time_tween0()
	elif life_time <= 10:
		if not is_level1_started:
			life_time_tween1()
	elif life_time <= 20:
		if not is_level2_started:
			life_time_tween2()

func life_time_tween2():
	is_level2_started = true
	blink_tween = create_tween()
	blink_tween.set_loops(10)
	blink_tween.tween_property($AnimatedSprite2D, "modulate", Color(5, 5, 5), 0)
	blink_tween.tween_interval(0.05)
	blink_tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1), 0)
	blink_tween.tween_interval(0.95)

func life_time_tween1():
	is_level1_started = true
	if blink_tween:
		blink_tween.kill()   # level2 깜빡임 정지
	blink_tween = create_tween()
	blink_tween.set_loops(20)
	blink_tween.tween_property($AnimatedSprite2D, "modulate", Color(5, 5, 5), 0)
	blink_tween.tween_interval(0.05)
	blink_tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1), 0)
	blink_tween.tween_interval(0.45)

func life_time_tween0():
	is_level0_started = true
	if blink_tween:
		blink_tween.kill()   # 깜빡임 정지
	$CollisionShape2D.disabled = true
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.tween_callback(queue_free)   # 다 사라지면 노드 제거

func start_tween():
	var tween = Global.create_spawn_tween(self, 0.5, 0.7)
	tween.tween_callback(func(): $CollisionShape2D.disabled = false)

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
		Global.add_yield(Global.fa_total_strawberry)
		queue_free()
	)
