extends Node2D
@onready var ninepatch: NinePatchRect = $ninepatch


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.position = get_parent().position
	selected_effect()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ninepatch.pivot_offset = ninepatch.size / 2 - Vector2(-1.2, -1.2)

func selected_effect():
	# 부모노드의 가로세로 사이즈를 가져온 다음에 그 사이즈 보다 조금씩 키워서 띄우고 트윈으로 커졌다가 작아졌다가 반복하기
	var orignal_size = get_parent().get_parent().size / 6 + Vector2(1, 1)
	print(get_parent())
	var big_size = orignal_size + Vector2(2, 2)
	ninepatch.size = orignal_size
	print(orignal_size)
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(ninepatch, "size", big_size, 0.5)
	tween.tween_property(ninepatch, "size", orignal_size, 0.5)
	
func remove_node():
	self.queue_free()
