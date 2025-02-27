class_name PlayerHurt
extends State

@export var player: Player
@onready var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter() -> void:
  sprite.play("hurt")

func _physics_update(_delta: float) -> void:
  pass

func _on_animated_sprite_2d_animation_finished() -> void:
  if sprite.animation == "hurt":
    transition_to.emit(self, "idle")
