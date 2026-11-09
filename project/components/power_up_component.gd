class_name PowerupComponent
extends Node

@export var player: Player
@onready var state: StateComponent = player.get_node("StateComponent")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		init_power()
	else:
		printerr("No player!!!")


func init_power() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
