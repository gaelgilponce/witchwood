extends AnimatedSprite2D

func _process(delta: float) -> void:
	play("default")
	check_player_proximity(delta)

@export var points: int = 20
@export var hits_to_die: int = 2
@export var damage_range: float = 100.0  # Distancia en píxeles para causar daño
@export var damage_per_second: float = 1.0  # Daño que recibe el enemigo por segundo
@export var damage_interval: float = 0.5  # Intervalo entre daños (en segundos)

var current_hits: int = 0
var damage_timer: float = 0.0
var player: Node2D
var is_player_in_range: bool = false  # Para evitar spam de logs

func _ready() -> void:
	add_to_group("ghosts")
	print("[ENEMY] Enemigo inicializado - ID: ", get_instance_id())
	
	# Buscar el jugador en la escena
	player = %CHARACTER
	if player:
		print("[ENEMY] Jugador encontrado: ", player.name)
	else:
		print("[ENEMY] ERROR: No se encontró jugador en el grupo 'player'")

func check_player_proximity(delta: float) -> void:
	if not player:
		return
	
	var distance = global_position.distance_to(player.global_position)
	
	if distance <= damage_range:
		# Log cuando el jugador entra en rango (solo una vez)
		if not is_player_in_range:
			print("[ENEMY] Jugador entró en rango de daño - Distancia: ", snappedf(distance, 0.01))
			is_player_in_range = true
		
		damage_timer += delta
		
		if damage_timer >= damage_interval:
			var damage_amount = damage_per_second * damage_interval
			print("[ENEMY] Aplicando daño: ", damage_amount, " - Vida actual: ", snappedf(current_hits, 0.01), "/", hits_to_die)
			
			# El enemigo recibe daño cuando el jugador está cerca
			take_damage(damage_amount)
			damage_timer = 0.0
	else:
		# Log cuando el jugador sale del rango (solo una vez)
		if is_player_in_range:
			print("[ENEMY] Jugador salió del rango de daño - Distancia: ", snappedf(distance, 0.01))
			is_player_in_range = false
		
		# Resetear el timer si el jugador se aleja
		damage_timer = 0.0

func take_damage(amount: float) -> void:
	var old_hits = current_hits
	current_hits += 1
	print("[ENEMY] Daño recibido: ", amount, " - Vida: ", snappedf(old_hits, 0.01), " → ", snappedf(current_hits, 0.01))
	
	if current_hits >= hits_to_die:
		print("[ENEMY] ¡Enemigo muriendo! Vida final: ", snappedf(current_hits, 0.01), "/", hits_to_die)
		die()

func die() -> void:
	print("[ENEMY] Enemigo eliminado - Puntos otorgados: ", points)
	#Global.increment_score(points)
	queue_free()
