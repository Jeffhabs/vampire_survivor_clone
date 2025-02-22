class_name PlayerHurt
extends State

@export var player: Player
@export var speed := 65.0
@onready var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter() -> void:
  sprite.play("hurt")

func _physics_update(_delta: float) -> void:
  player.direction = Vector2.ZERO

func _on_animated_sprite_2d_frame_changed() -> void:
  if sprite.animation == "hurt" and sprite.frame == sprite.sprite_frames.get_frame_count("hurt") - 1:
    transition_to.emit(self, "idle")
