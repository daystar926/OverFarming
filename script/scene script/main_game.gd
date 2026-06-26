extends Control
@onready var cloud_anim: AnimationPlayer = $"sky/cloud anim"

@onready var sky_cloud_2_1: TextureRect = $"sky/sky cloud 2-1"
@onready var sky_cloud_2_2: TextureRect = $"sky/sky cloud 2-2"
@onready var sky_cloud_2_3: TextureRect = $"sky/sky cloud 2-3"

@onready var sky_cloud_1_1: TextureRect = $"sky/sky cloud 1-1"
@onready var sky_cloud_1_2: TextureRect = $"sky/sky cloud 1-2"
@onready var sky_cloud_1_3: TextureRect = $"sky/sky cloud 1-3"

func _ready() -> void:
	cloud_anim.play("cloud 1")
	Global.stat_refresh()

func _process(delta: float) -> void:
	pass
	

	
