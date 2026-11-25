extends Area2D

@export var pool: Array[PowerUp] # drag your .tres resources in here
@onready var ui = $PowerupChoiceUI
var player_in_range: Player

func _ready() -> void:
	body_entered.connect(func(body: Node2D) -> void:
		if body is Player: player_in_range = body)
	body_exited.connect(func(body: Node2D) -> void:
		if body == player_in_range: player_in_range = null)
	ui.chosen.connect(_on_chosen)

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		var options := pool.duplicate()
		options.shuffle()
		ui.show_choices(options.slice(0, 3))
		get_viewport().set_input_as_handled()

func _on_chosen(powerup: PowerUp) -> void:
	player_in_range.equip(powerup)
	queue_free() # one-time use; drop this if the item should be reusable