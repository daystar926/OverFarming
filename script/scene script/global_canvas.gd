extends CanvasLayer

@onready var white_color: ColorRect = $"white color"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func white_transition(path):

	
	animation_player.play("white in")
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file(path)
	await get_tree().tree_changed
	
	animation_player.play("white out")
