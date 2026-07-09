extends Control

@onready var back_clouod_anim: AnimationPlayer = $"Parallax2D2/back clouod anim"
@onready var cloud_anim: AnimationPlayer = $"Parallax2D4/cloud anim"

func _ready() -> void:
	Global.stat_refresh()
	back_clouod_anim.play("cloud anim1")
	cloud_anim.play("cloud anim2")

func _process(delta: float) -> void:
	pass
	
