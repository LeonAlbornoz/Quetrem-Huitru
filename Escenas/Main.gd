extends Node2D

@onready var UI = $UI
@onready var Player = $Player
@onready var anim: AnimationPlayer = $Animacion
@onready var gameMusic = $GameMusic
@onready var Potrillo = $Potrillo
@onready var audioManager = $"/root/AudioManager"

const DIALOGUE = preload("uid://btp44lxu4vgap")

func _ready() -> void:
	gameMusic.autoplay = true
	gameMusic.play()
	UI.get_node("IntroMusic").stop()
	$Fade.visible = true
	anim.play("Inicio")
	Player.InputOFF = true
	UI.get_node("Main").visible = false
	await get_tree().create_timer(0.8).timeout
	DialogueManager.show_dialogue_balloon(DIALOGUE, "Comienzo")
	await DialogueManager.dialogue_ended
	anim.play("VaSaliendo")
	await get_tree().create_timer(2).timeout
	DialogueManager.show_dialogue_balloon(DIALOGUE, "VaSaliendo")
	await DialogueManager.dialogue_ended
	anim.play("VeAlPotrillo")
	#audioManager.get_node("Galope").play()
	#Potrillo.get_node("RelinchoAudio").play()
	await get_tree().create_timer(3).timeout
	#Potrillo.get_node("GalopeAudio").autoplay = true
	
	DialogueManager.show_dialogue_balloon(DIALOGUE, "VeAlPotrillo")
	await DialogueManager.dialogue_ended
	DeadPotrillo($Potrillo)
	Player.InputOFF = false

func Calden(player: Node2D) -> void:
	if player.Piezas >= 2:
		player.InputOFF = true
		anim.play("Final")
		await get_tree().create_timer(10).timeout
		UI.get_node("Fade").visible = true
		UI.anim.play("Ganaste")
		await get_tree().create_timer(0.4).timeout
		player.queue_free()
	else:
		player.InputOFF = true
		player.anim.play("Idle_" + player.last_direction)
		DialogueManager.show_dialogue_balloon(DIALOGUE, "SinPiezas")
		await DialogueManager.dialogue_ended
		player.InputOFF = false
	Potrillo.queue_free()

func _on_pieza_1_body_entered(player: Node2D) -> void:
	player.InputOFF = true
	get_node("Pieza1").queue_free()
	if player.Piezas == 0:
		DialogueManager.show_dialogue_balloon(DIALOGUE, "UnaPieza")
		await DialogueManager.dialogue_ended
	elif player.Piezas == 1:
		DialogueManager.show_dialogue_balloon(DIALOGUE, "DosPiezas")
		await DialogueManager.dialogue_ended
	player.Piezas += 1
	anim.play("Pieza1")

func _on_pieza_2_body_entered(player: Node2D) -> void:
	player.InputOFF = true
	get_node("Pieza2").queue_free()
	if player.Piezas == 0:
		DialogueManager.show_dialogue_balloon(DIALOGUE, "UnaPieza")
		await DialogueManager.dialogue_ended
	elif player.Piezas == 1:
		DialogueManager.show_dialogue_balloon(DIALOGUE, "DosPiezas")
		await DialogueManager.dialogue_ended
	player.Piezas += 1
	anim.play("Pieza2")

func DeadPotrillo(_body: Node2D) -> void:
	anim.play("DeadPotrillo")

func PasilloCalden(body: Node2D) -> void:
	if body.Piezas < 2: return
	anim.play("PasilloCalden")
	
	get_node("PasilloCalden").queue_free()
	
