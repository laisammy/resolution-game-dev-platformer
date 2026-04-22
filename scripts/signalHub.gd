extends Node

signal timeLeft
signal fetchNextWord

func emit_timeLeft(time: float) -> void:
	timeLeft.emit(time)
	
func emit_fetchNextWord() -> void:
	fetchNextWord.emit()
