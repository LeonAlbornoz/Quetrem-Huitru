extends CharacterBody2D

@export var speed = 300
@export var block = false

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

@onready var anim: AnimatedSprite2D = $Anim

func _ready() -> void:
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 10.0

func _physics_process(_delta: float) -> void:
	if block:
		$Collision.disabled = true
		return
	
	if player == null:
		return
	
	nav_agent.target_position = player.global_position
	
	var next_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_pos)
	
	velocity = direction * speed
	
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim.play("Walk_Right")
		else:
			anim.play("Walk_Left")
	else:
		if direction.y > 0:
			anim.play("Walk_Down")
		else:
			anim.play("Walk_Up")
	
	move_and_slide()
