extends Node

# Variables de puntuación
var player_score: int = 0
var required_score: int = 60

# Señal para actualizar la UI
signal score_updated(new_score: int)

func _ready() -> void:
	player_score = 0

func increment_score(points: int) -> void:
	player_score += points
	print("¡Fantasma eliminado! +%d puntos. Total: %d" % [points, player_score])
	score_updated.emit(player_score)

func add_points(points: int) -> void:
	increment_score(points)

func reset_score() -> void:
	player_score = 0
	score_updated.emit(player_score)
