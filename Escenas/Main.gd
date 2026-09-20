extends Node2D

### Por Hacer ###
#Puede que Pausa(ya agregue una entrada(Esc y la P)
#Terminar de Acomodar el Mapa

@onready var UI = $UI
@onready var Player = $Player
@onready var anim: AnimationPlayer = $Animacion

func _ready() -> void:
	$Fade.visible = true
	$Fade.position = Player.get_node("Camera2D").position - Vector2(120, 50)
	anim.play("Inicio")
	Player.InputOFF = true
	UI.get_node("Main").visible = false
	await get_tree().create_timer(0.8).timeout
	Player.InputOFF = false

func _on_area_2d_body_entered(player: Node2D) -> void:
	if player.Piezas >= 2:
		UI.get_node("Fade").visible = true
		UI.anim.play("Ganaste")
		await get_tree().create_timer(0.4).timeout
		player.queue_free()

func _on_pieza_1_body_entered(player: Node2D) -> void:
	player.Piezas += 1
	get_node("Pieza1").queue_free()

func _on_pieza_2_body_entered(player: Node2D) -> void:
	player.Piezas += 1
	get_node("Pieza2").queue_free()
