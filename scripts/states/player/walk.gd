class_name PlayerWalk
extends State

@export var player: Player
@export var speed := 65.0
@onready var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter() -> void:
  sprite.play("walk")

func _physics_update(_delta: float) -> void:
  if player.velocity == Vector2.ZERO:
    transition_to.emit(self, "idle")