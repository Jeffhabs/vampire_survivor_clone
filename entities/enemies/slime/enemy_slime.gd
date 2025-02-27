class_name EnemySlime
extends CharacterBody2D

# TODO: set this up to use an enemy resource with stats etc

@onready var player := get_tree().get_first_node_in_group("player")
@onready var sprite := $AnimatedSprite2D
@onready var state_machine := $StateMachine
@onready var attack_strategy: AttackStrategy = get_node("UnarmedAttack")

enum SlimeAttacks {
  SWORD_ATTACK,
  UNARMED_ATTACK
}

@export var speed := 20.0
@export var health_points := 10

func _ready() -> void:
  var attack = SlimeAttacks.values().pick_random()
  match attack:
    SlimeAttacks.SWORD_ATTACK:
      attack_strategy = get_node("SwordAttack")
    SlimeAttacks.UNARMED_ATTACK:
      attack_strategy = get_node("UnarmedAttack")

func _physics_process(_delta: float) -> void:
  pass

func _on_hurt_box_hurt(damage: int) -> void:
  health_points -= damage
  if health_points <= 0:
    state_machine.transition_to("death")
  else:
    state_machine.transition_to("hurt")
