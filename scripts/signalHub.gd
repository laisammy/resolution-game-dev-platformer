extends Node

signal timeLeft
signal fetchNextWord
signal collectCoin

func emit_timeLeft(time: float) -> void:
	timeLeft.emit(time)
	
func emit_fetchNextWord() -> void:
	fetchNextWord.emit()
	
func emit_collectCoin() -> void:
	collectCoin.emit()
