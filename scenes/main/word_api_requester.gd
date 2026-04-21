extends Node

@onready var word_api_requester: HTTPRequest = $"."
var words = []

func _ready():
	fetch_words()

func fetch_words():
	var url = "https://random-word-api.herokuapp.com/word?number=1"  # Adjust for more words
	word_api_requester.request(url)

func spawn_words():
	for word in words:
		# create a word node (we'll define this next)
		var word_node = preload("res://scenes/word/word.tscn").instantiate()
		word_node.set_word(word)
		word_node.position = Vector2(randf_range(0, 800), randf_range(0, 600))  # random position
		add_child(word_node)
		word_node.call_deferred("set_word", word)


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		words = json  # Assuming it returns an array of strings
		print("Fetched words: ", words)
		# now, spawn word objects in the game
		spawn_words()
	else:
		print("Failed to fetch words")
