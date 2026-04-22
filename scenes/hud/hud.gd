extends Control
@onready var label: Label = $label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.timeLeft.connect(displayTimeLeft)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func displayTimeLeft(timeLeft: float) -> void:
	var msec = fmod(timeLeft, 1) * 10
	var sec = fmod(timeLeft, 60)
	var formatString = "%01d.%01d"
	var actualString = formatString % [sec, msec]
	label.text = "Jump Boost Time Left: " + actualString
