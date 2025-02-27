class_name AttackStrategy
extends Node2D

# TODO: this might be too abstract...

@export var attack_range: float
@export var damage: int
@export var animation_name: String

func _play_animation() -> void:
  pass

func _attack() -> void:
  pass

func _update_hitbox_orientation(_to_player: Vector2) -> void:
  pass