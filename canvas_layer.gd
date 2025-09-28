extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@export var door: NodePath
var door_ref: Area2D

func _ready() -> void:
	if door != NodePath():
		door_ref = get_node(door)
	else:
		print("Error: No se ha asignado la puerta en el inspector")
		return
	
	# Solo continúa si door_ref existe
	#if door_ref != null:
		#Global.score_updated.connect(_on_score_updated)
		#_on_score_updated(Global.player_score)  # inicializa

func _on_score_updated(new_score: int) -> void:
	var remaining = max(0, door_ref.required_score - new_score)
	score_label.text = "Puntos: %d  |  Falta: %d" % [new_score, remaining]
