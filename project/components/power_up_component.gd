class_name PowerupComponent
extends Node

var player: Player
var state: StateComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var node := get_parent()
	while node != null and node is not Player:
		node = node.get_parent()
	player = node as Player
	if player:
		state = player.get_node("StateComponent")
		init_power()
	else:
		printerr("No player!!!")


func init_power() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
