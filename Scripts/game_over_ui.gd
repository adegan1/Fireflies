extends CanvasLayer

signal restart_clicked

@onready var label: Label = $Control/ColorRect/Label
@onready var button: Button = $Control/Button

var insults = [
	"Pathetic.",
	"Is that all?",
	"Disappointing.",
	"Tsk, try again.",
	"You can do better.",
	"Weakness disgusts me."
]

func _ready() -> void:
	# Pause the game when this screen appears
	get_tree().paused = true
	
	if label:
		label.text = insults.pick_random()
	
	if button:
		button.pressed.connect(_on_restart_pressed)

func _on_restart_pressed() -> void:
	print("Restart button pressed!")

	# Unpause the game
	get_tree().paused = false

	# Reload the current scene
	get_tree().reload_current_scene()

	queue_free()


func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_restart_clicked() -> void:
	pass # Replace with function body.
