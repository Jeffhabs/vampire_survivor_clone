extends State

@export var enemy: CharacterBody2D
@export var attack_range := 59.0

@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter():
  sprite.play("hurt")

func _physics_update(_delta: float):
  enemy.velocity = Vector2.ZERO

func _on_animated_sprite_2d_animation_finished() -> void:
  if sprite.animation == "hurt":
    transition_to.emit(self, "chase")