extends CanvasLayer

@onready var anim: AnimationPlayer = $Fade/AnimationPlayer

func _ready() -> void:
	$Reintentar.visible = false
	$Victoria.visible = false
	$Fade.visible = false

func _on_iniciar_pressed() -> void:
	if not $Fade.visible:
		anim.play("Iniciar")
		$Fade.visible = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Escenas/Main.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/UI.tscn")
