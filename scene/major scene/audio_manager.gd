extends Node


const FADE_TIME: float = 1.0
const SILENT_DB: float = -40.0
const SFX_DB: float = 0.0
# 키 → 리소스 경로
var bgm_library: Dictionary = {
	"main": "res://Assets/sound/BGM/main menu bgm.mp3",
	"lobby": "res://Assets/sound/BGM/lobby bgm.mp3",
	"game": "res://Assets/sound/BGM/main game bgm.mp3",
	"game over": "res://Assets/sound/BGM/game over bgm.mp3",
}
var sfx_library: Dictionary = {
	"boo":"res://Assets/sound/sfx/boo.mp3",
	"button": "res://Assets/sound/sfx/button.mp3",
	"card hover": "res://Assets/sound/sfx/card hover.wav",
	"card select": "res://Assets/sound/sfx/card select.mp3",
	"card select2": "res://Assets/sound/sfx/card select 2_c.mp3",
	"card to inven": "res://Assets/sound/sfx/card to inven_c.mp3",
	"crash": "res://Assets/sound/sfx/crashing sound_c.mp3",
	"day over": "res://Assets/sound/sfx/day over bell.wav",
	"failure": "res://Assets/sound/sfx/failure.mp3",
	"highlight": "res://Assets/sound/sfx/highlight.mp3",
	"item collect": "res://Assets/sound/sfx/item collect_c.mp3",
	"plant": "res://Assets/sound/sfx/plant_c.mp3",
	"shelf": "res://Assets/sound/sfx/shelf.mp3",
	"transition": "res://Assets/sound/sfx/transition_c.mp3",
	"yield": "res://Assets/sound/sfx/yield_c.mp3",
}

var _bgm_players: Array[AudioStreamPlayer] = []
var _sfx_players: Array[AudioStreamPlayer] = []
var _cache: Dictionary = {}
var _bgm_index: int = 0
var _current_bgm_key: String = ""

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	for child in get_children():
		if child is AudioStreamPlayer:
			if child.bus == "BGM":
				child.volume_db = SILENT_DB
				_bgm_players.append(child)
			elif child.bus == "SFX":
				_sfx_players.append(child)

	assert(_bgm_players.size() == 2, "BGM 플레이어는 2개여야 합니다.")
	assert(_sfx_players.size() > 0, "SFX 플레이어가 없습니다.")

func _get_stream(path: String) -> AudioStream:
	if not _cache.has(path):
		_cache[path] = load(path)
	return _cache[path]


func play_bgm(key: String, fade_time: float = FADE_TIME) -> void:
	if key == _current_bgm_key:
		return
	if not bgm_library.has(key):
		push_warning("BGM 키를 찾을 수 없습니다: %s" % key)
		return

	_current_bgm_key = key
	var old_player: AudioStreamPlayer = _bgm_players[_bgm_index]
	_bgm_index = 1 - _bgm_index
	var new_player: AudioStreamPlayer = _bgm_players[_bgm_index]

	new_player.stream = _get_stream(bgm_library[key])
	new_player.volume_db = SILENT_DB
	new_player.play()

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(new_player, "volume_db", 0.0, fade_time)
	if old_player.playing:
		tween.tween_property(old_player, "volume_db", SILENT_DB, fade_time)
		tween.chain().tween_callback(old_player.stop)


func stop_bgm(fade_time: float = FADE_TIME) -> void:
	_current_bgm_key = ""
	for p in _bgm_players:
		if p.playing:
			var tween := create_tween()
			tween.tween_property(p, "volume_db", SILENT_DB, fade_time)
			tween.tween_callback(p.stop)


func play_sfx(key: String, pitch_variation: float = 0.0) -> void:
	if not sfx_library.has(key):
		push_warning("SFX 키를 찾을 수 없습니다: %s" % key)
		return

	var player: AudioStreamPlayer = _get_idle_sfx_player()
	if player == null:
		return

	player.stream = _get_stream(sfx_library[key])
	player.volume_db = SFX_DB
	player.pitch_scale = 1.0 + randf_range(-pitch_variation, pitch_variation)
	player.play()


func _get_idle_sfx_player() -> AudioStreamPlayer:
	for p in _sfx_players:
		if not p.playing:
			return p
	return null


func set_bus_volume(bus_name: String, linear: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		return
	linear = clampf(linear, 0.0, 1.0)
	AudioServer.set_bus_volume_db(idx, linear_to_db(linear))
	AudioServer.set_bus_mute(idx, linear <= 0.001)


func get_bus_volume(bus_name: String) -> float:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		return 0.0
	return db_to_linear(AudioServer.get_bus_volume_db(idx))
