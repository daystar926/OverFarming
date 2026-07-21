extends RichTextLabel

@export var typing_speed: float = 0.1  # 글자당 대기 시간(초)

func type_text(text_con: String):
	bbcode_enabled = true
	text = text_con
	visible_characters = 0
	visible_ratio = 0.0
	
	var char_count = get_total_character_count()
	for i in range(char_count + 1):
		visible_characters = i
		await get_tree().create_timer(typing_speed).timeout
