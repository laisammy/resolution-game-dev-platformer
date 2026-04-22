extends Control
@onready var jump_boost: Label = $jumpBoost
@onready var coins_collected: Label = $coinsCollected

var coins = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.timeLeft.connect(displayTimeLeft)
	SignalHub.collectCoin.connect(collectCoin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func displayTimeLeft(timeLeft: float) -> void:
	var msec = fmod(timeLeft, 1) * 10
	var sec = fmod(timeLeft, 60)
	var formatString = "%01d.%01d"
	var actualString = formatString % [sec, msec]
	jump_boost.text = "Jump Boost Time Left: " + actualString
	
func collectCoin() -> void:
	coins += 1
	coins_collected.text = "Coins Collected: " + str(coins)
	
