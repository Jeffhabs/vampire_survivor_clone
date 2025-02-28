class_name AttackStrategy
extends Node2D

# TODO: this might be too abstract... or maybe MeleeAttackStrategy would be better?

@export var attack_range: float
@export var damage: int
@export var animation_name: String
@export var attack_start_frame: int
@export var attack_end_frame: int

func _play_animation() -> void:
  pass

func _attack() -> void:
  pass

func _update_hitbox_orientation(_to_player: Vector2) -> void:
  pass