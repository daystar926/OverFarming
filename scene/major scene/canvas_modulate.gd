extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60

## 하루(1440분)가 현실 시간으로 몇 초 걸릴지 정하는 기준값
## day_length_seconds=1440×원하는 게임 내 분/원하는 현실 초​
@export var day_length_seconds: float = 288

@export var gradient: GradientTexture1D

var time = 0.0
var past_minute: float = -1.0
var total_minutes = 0

signal time_tick(day: int, hour: int, minute: int)
signal night_time()

func _ready():
	Global.time_stop_signal.connect(time_stop)
	Global.time_start_signal.connect(time_start)
	Global.to_next_morning.connect(go_to_next_morning)
	set_time(1, 8, 0)

var time_passable = true
func _process(delta: float) -> void:
	if time_passable:
		time += delta

		# 0~1 사이 값으로 하루 진행률을 구함 (fmod로 하루마다 반복)
		var day_progress = fmod(time, day_length_seconds) / day_length_seconds
		var angle = day_progress * 2.0 * PI

		var value = (sin(angle - PI / 2) + 1.0) / 2.0
		self.color = gradient.gradient.sample(value)

		_recalculate_time()

var is_nighttime_passed = false
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
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
		

## 라운드 보상 시간에 시간 흐르지 않도록 멈추는 함수
func time_stop():
	time_passable = false

func time_start():
	time_passable = true

## 원하는 day / hour / minute으로 시간을 설정
func set_time(day: int, hour: int, minute: int) -> void:
	var minute_of_day = hour * MINUTES_PER_HOUR + minute
	var day_progress = float(minute_of_day) / float(MINUTES_PER_DAY)
	time = float(day) * day_length_seconds + day_progress * day_length_seconds
	
	_recalculate_time()
	
## 현재 몇 시든 상관없이 무조건 다음날 오전 8시로 이동시키는 함수
func go_to_next_morning() -> void:
	var current_day = int(time / day_length_seconds)
	set_time(current_day + 1, 8, 0)
