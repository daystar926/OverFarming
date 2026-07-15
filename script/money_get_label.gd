extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func money_get_anim(money):
	$Label.visible = true
	$Label.text = "+ " + str(Global.format_num_custom(money)) + " G"
	var tween = create_tween()
	tween.tween_property($Label, "position.y", -50, 1)
