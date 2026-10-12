extends CanvasLayer

@onready var health_bar: ProgressBar = $Control/MarginContainer/VBoxContainer/HealthBar

var health: HealthComponent


func _ready() -> void:
	print("HUD ready")
	var player := get_tree().get_first_node_in_group("player")
	if player == null:
		push_warning("HUD: no node in group 'player' found")
		return

	health = player.health
	health_bar.max_value = health.max_health
	health_bar.value = health.current_health
	print("HUD: max=", health.max_health, " current=", health.current_health)
	health.health_changed.connect(_on_health_changed)


func _on_health_changed(new_amount: float) -> void:
	health_bar.value = new_amount