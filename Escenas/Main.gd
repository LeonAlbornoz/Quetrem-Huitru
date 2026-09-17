extends Node2D

@onready var UI = get_tree().get_first_node_in_group("UI")

func _on_area_2d_body_entered(player: Node2D) -> void:
	if player.Piezas >= 2:
		UI.get_node("Ganaste").visible = true

func _on_pieza_1_body_entered(player: Node2D) -> void:
	player.Piezas += 1
	get_node("Pieza1").queue_free()

func _on_pieza_2_body_entered(player: Node2D) -> void:
	player.Piezas += 1
	get_node("Pieza2").queue_free()
