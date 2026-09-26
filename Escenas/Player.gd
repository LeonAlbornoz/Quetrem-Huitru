extends CharacterBody2D

@export var speed = 4000
@export var Piezas = 0
@export var InputOFF = false
const DIALOGUE = preload("uid://btp44lxu4vgap")

@onready var anim: AnimatedSprite2D = $Anim
@onready var UI = get_tree().get_first_node_in_group("UI")
@onready var Potrillo = get_tree().get_first_node_in_group("Potrillo")

var last_direction: String = "Down"
var is_dialogue_active = false

func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

### SI QUERES QUE VUELVA A APARECER EL TEXTO CON EL ESPACIO SACA # EN EL PROCESS ###

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept") and not is_dialogue_active:
		#DialogueManager.show_dialogue_balloon(DIALOGUE, "start")

func _physics_process(_delta: float) -> void:
	if InputOFF:
		return
	
	var direction: Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
		
		if abs(direction.x) > abs(direction.y):
			last_direction = "Right" if direction.x > 0 else "Left"
		else:
			last_direction = "Down" if direction.y > 0 else "Up"
		
		anim.play("Walk_" + last_direction)
	else:
		velocity = Vector2.ZERO
		anim.play("Idle_" + last_direction)
	
	move_and_slide()

func _on_muerte_body_entered(_body: Node2D) -> void:
	UI.anim.play("Perdiste")
	UI.get_node("Fade").visible = true
	await get_tree().create_timer(0.4).timeout
	Potrillo.queue_free()
	queue_free()

func _on_dialogue_started(_dialogue):
	is_dialogue_active = true

func _on_dialogue_ended(_dialogue):
	is_dialogue_active = false
