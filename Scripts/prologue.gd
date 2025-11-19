extends PrologueScene

@onready var animation_player: AnimationPlayer = $"Animation Player"

func _ready() -> void:
	animation_player.play("Prologue")
