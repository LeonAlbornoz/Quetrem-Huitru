extends Node2D

@onready var UI = $UI
@onready var Player = $Player
@onready var anim: AnimationPlayer = $Animacion

const DIALOGUE = preload("uid://btp44lxu4vgap")
const BALLOON = preload("res://Escenas/Dialogue/balloon.tscn")

func _ready() -> void:
	$Fade.visible = true
	#$Fade.position = Player.get_node("Camera2D").position - Vector2(-70, 2700)
	anim.play("Inicio")
	Player.InputOFF = true
	UI.get_node("Main").visible = false
	await get_tree().create_timer(0.8).timeout
	DialogueManager.show_dialogue_balloon_scene(BALLOON, DIALOGUE, "start")
	await DialogueManager.dialogue_ended
	Player.InputOFF = false

func Calden(player: Node2D) -> void:
	if player.Piezas >= 2:
		UI.get_node("Fade").visible = true
		UI.anim.play("Ganaste")
		await get_tree().create_timer(0.4).timeout
		player.queue_free()
	else:
		player.InputOFF = true
		player.anim.play("Idle_" + player.last_direction)
		DialogueManager.show_dialogue_balloon_scene(BALLOON, DIALOGUE, "SinPiezas")
		await DialogueManager.dialogue_ended
		player.InputOFF = false

func _on_pieza_1_body_entered(player: Node2D) -> void:
	player.Piezas += 1
	get_node("Pieza1").queue_free()
	anim.play("Pieza1")

func _on_pieza_2_body_entered(player: Node2D) -> void:
	player.Piezas += 1
	get_node("Pieza2").queue_free()
	anim.play("Pieza2")

func DeadPotrillo(body: Node2D) -> void:
	body.get_node("Collision").set_deferred("disbaled", false)
	body.block = true
	body.visible = false

func PasilloCalden(_body: Node2D) -> void:
	anim.play("PasilloCalden")
	get_node("PasilloCalden").queue_free()
