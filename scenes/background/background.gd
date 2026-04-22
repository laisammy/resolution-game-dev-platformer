extends Control
@onready var random_duck_api: HTTPRequest = $randomDuckAPI
@onready var texture_rect: TextureRect = $textureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fetch_duck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fetch_duck():
	var url = "https://random-d.uk/api/random"
	random_duck_api.request(url)

func _on_random_duck_api_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8())
	var image_url = json["url"]
	# load texture (use a separate httprequest for image)
	var image_request = HTTPRequest.new()
	add_child(image_request)
	image_request.request(image_url)
	# then set to sprite
	image_request.request_completed.connect(_on_image_downloaded)
	
func _on_image_downloaded(result, response_code, headers, body):
	if response_code != 200:
		print("Image download failed:", response_code)
		return

	var img := Image.new()
	var err: int = img.load_jpg_from_buffer(body)

	if err != OK:
		print("Failed to load image buffer:", err)
		return

	var tex := ImageTexture.create_from_image(img)
	texture_rect.texture = tex
