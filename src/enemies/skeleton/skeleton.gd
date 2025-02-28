class_name EnemySkeleton
extends CharacterBody2D

enum SkeletonAttacks {
  SWORD_ATTACK,
  # UNARMED_ATTACK
}

@onready var player := get_tree().get_first_node_in_group("player")
@onready var sprite := $AnimatedSprite2D
@onready var state_machine := $StateMachine
@onready var attack_strategy: AttackStrategy = $SwordAttack

@export var speed := 20.0
@export var health_points := 10

func _ready() -> void:
  assert(attack_strategy, "Attack strategy not set. (Skeleton)")
  var attack = SkeletonAttacks.values().pick_random()
  match attack:
    SkeletonAttacks.SWORD_ATTACK:
      attack_strategy = get_node("SwordAttack")

func _on_hurt_box_hurt(damage: int) -> void:
  health_points -= damage
  if health_points <= 0:
    state_machine.transition_to("death")
  else:
    state_machine.transition_to("hurt")

func _on_animated_sprite_2d_animation_finished() -> void:
  match sprite.animation:
    attack_strategy.animation_name:
      state_machine.transition_to("chase")
    "hurt":
      state_machine.transition_to("chase")
    "death":
      get_tree().create_timer(1).timeout.connect(queue_free)

func _on_animated_sprite_2d_frame_changed() -> void:
  if attack_strategy:
    if sprite.animation == attack_strategy.animation_name:
      attack_strategy._attack()
