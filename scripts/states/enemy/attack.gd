class_name EnemyAttack
extends State

@export var enemy: EnemySlime
@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D

var player: CharacterBody2D

func _enter() -> void:
  enemy.attack_strategy._play_animation()
  player = get_tree().get_first_node_in_group("player")

func _physics_update(_delta: float) -> void:
  if player and enemy:
    var distance_to_player := enemy.global_position.distance_to(player.global_position)
    var direction_to_player := enemy.global_position.direction_to(player.global_position)
    enemy.velocity = direction_to_player.normalized() * enemy.speed
    enemy.move_and_slide()

    if distance_to_player > enemy.attack_strategy.attack_range:
      transition_to.emit(self, "chase")

func _on_animated_sprite_2d_frame_changed() -> void:
  if enemy.attack_strategy:
    if sprite.animation == enemy.attack_strategy.animation_name:
      enemy.attack_strategy._attack()

func _on_animated_sprite_2d_animation_finished() -> void:
  if enemy.attack_strategy:
    if sprite.animation == enemy.attack_strategy.animation_name:
      transition_to.emit(self, "chase")