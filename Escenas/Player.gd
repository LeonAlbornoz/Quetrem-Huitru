extends CharacterBody2D

@export var speed = 300

@onready var anim: AnimatedSprite2D = $Anim

var last_direction: String = "Down"

@export var Piezas = 0

func _physics_process(_delta: float) -> void:
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
