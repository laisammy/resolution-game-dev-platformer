extends Area2D

var word: String
var typed = ""

@onready var word_label: Label = $wordLabel

func _input(event):
	if word_label == null:
		return
	if event is InputEventKey and event.pressed:
		if event.unicode > 0:
			var ch := char(event.unicode)
			if ch.is_valid_identifier():
				typed += ch
				update_display()
				if typed == word:
					queue_free()
					get_tree().root.get_node("main/player").boost_jump()

func update_display():
	word_label.text = word.substr(typed.length())  # Show remaining letters
	
func set_word(w: String) :
	word = w
	if word_label:
		word_label.text = word
