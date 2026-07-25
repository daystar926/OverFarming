extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60

## 하루(1440분)가 현실 시간으로 몇 초 걸릴지 정하는 기준값
## day_length_seconds=1440×원하는 게임 내 분/원하는 현실 초
@export var day_length_seconds: float = 288
@export var gradient: GradientTexture1D

## 빨리감기 배속 (1.0 = 평소 속도, 30.0 = 30배속)
@export var fast_forward_speed: float = 60.0

var time = 0.0
var past_minute: float = -1.0
var total_minutes = 0

signal time_tick(day: int, hour: int, minute: int)
signal night_time()

## clock_change가 발동할 시각 목록
const CLOCK_CHANGE_HOURS: Array[int] = [8, 11, 14, 17]
## 같은 시각에 중복 호출되지 않도록 마지막으로 실행한 시각을 저장 (day * 24 + hour)
var past_clock_key: int = -1
signal clock_changed(day: int, hour: int)

## 빨리감기 상태
var is_fast_forwarding: bool = false
var fast_forward_target: float = 0.0
signal fast_forward_started()
signal fast_forward_finished()

var time_passable = true
var is_nighttime_passed = false


func _ready():
	Global.time_stop_signal.connect(time_stop)
	Global.time_start_signal.connect(time_start)
	Global.to_next_morning.connect(go_to_next_morning)
	set_time(1, 8, 0)


func _process(delta: float) -> void:
	if Engine.time_scale > 0:
		Global.play_time += delta / Engine.time_scale

	if is_fast_forwarding:
		_advance_time(delta * fast_forward_speed)
	elif time_passable:
		_advance_time(delta)


## time을 amount만큼 진행시키되, 게임 내 1분 단위보다 크게 건너뛰지 않도록 잘게 나눠서 처리
func _advance_time(amount: float) -> void:
	if amount <= 0.0:
		return

	var finish_after: bool = false

	if is_fast_forwarding:
		var remaining: float = fast_forward_target - time
		if amount >= remaining:
			amount = remaining
			finish_after = true

	# 게임 내 1분에 해당하는 현실 시간 길이
	var step_limit: float = day_length_seconds / float(MINUTES_PER_DAY)
	var left: float = amount

	while left > 0.0:
		var step: float = min(step_limit, left)
		time += step
		left -= step
		_recalculate_time()

	_update_color()

	if finish_after:
		is_fast_forwarding = false
		fast_forward_finished.emit()


## 현재 time에 맞춰 화면 색상만 갱신
func _update_color() -> void:
	if gradient == null:
		return
	var day_progress: float = fmod(time, day_length_seconds) / day_length_seconds
	var angle: float = day_progress * 2.0 * PI
	var value: float = (sin(angle - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)


func _recalculate_time() -> void:
	# 하루 진행률(0~1)을 분 단위로 환산
	var day_progress = fmod(time, day_length_seconds) / day_length_seconds
	var current_day_minutes = int(day_progress * MINUTES_PER_DAY)
	var day = int(time / day_length_seconds)
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)

	if hour >= 18:
		if not is_nighttime_passed:
			is_nighttime_passed = true
			night_time.emit()
	else:
		is_nighttime_passed = false

	_check_clock_change(day, hour)

	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)


## 현재 시각이 지정된 시각인지 확인하고, 처음 진입했을 때만 clock_change 호출
func _check_clock_change(day: int, hour: int) -> void:
	if not CLOCK_CHANGE_HOURS.has(hour):
		return
	var clock_key: int = day * 24 + hour
	if past_clock_key == clock_key:
		return
	past_clock_key = clock_key
	




## 라운드 보상 시간에 시간 흐르지 않도록 멈추는 함수
func time_stop():
	time_passable = false


func time_start():
	time_passable = true


## 원하는 day / hour / minute으로 시간을 즉시 설정 (초기화용)
func set_time(day: int, hour: int, minute: int) -> void:
	var minute_of_day = hour * MINUTES_PER_HOUR + minute
	var day_progress = float(minute_of_day) / float(MINUTES_PER_DAY)
	time = float(day) * day_length_seconds + day_progress * day_length_seconds
	past_clock_key = -1
	is_fast_forwarding = false
	_recalculate_time()
	_update_color()


## 내부 time 값으로 환산 (현재 시각보다 앞이면 다음 날로 넘김)
func _time_value_of(day: int, hour: int, minute: int) -> float:
	var minute_of_day: int = hour * MINUTES_PER_HOUR + minute
	var day_progress: float = float(minute_of_day) / float(MINUTES_PER_DAY)
	return float(day) * day_length_seconds + day_progress * day_length_seconds


## 특정 day / hour / minute까지 빠르게 시간을 흘려보냄
func fast_forward_to(day: int, hour: int, minute: int, speed: float = -1.0) -> void:
	var target: float = _time_value_of(day, hour, minute)
	if target <= time:
		return
	if speed > 0.0:
		fast_forward_speed = speed
	fast_forward_target = target
	is_fast_forwarding = true
	fast_forward_started.emit()


## 날짜 상관없이 "다음에 오는 hour:minute"까지 빠르게 이동
func fast_forward_to_hour(hour: int, minute: int = 0, speed: float = -1.0) -> void:
	var current_day: int = int(time / day_length_seconds)
	var target: float = _time_value_of(current_day, hour, minute)
	while target <= time:
		target += day_length_seconds
	if speed > 0.0:
		fast_forward_speed = speed
	fast_forward_target = target
	is_fast_forwarding = true
	fast_forward_started.emit()


func go_to_next_morning() -> void:
	fast_forward_to(Global.current_round, 8, 0)
