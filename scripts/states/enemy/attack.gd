class_name EnemyAttack
extends State

@export var enemy: CharacterBody2D
@export var attack_range := 58.0

@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D
@onready var hitbox_collision := enemy.get_node("HitBox/CollisionShape2D") as CollisionShape2D

var player: CharacterBody2D


func _enter() -> void:
  sprite.play("attack")
  player = get_tree().get_first_node_in_group("player") as CharacterBody2D

func _physics_update(_delta: float) -> void:
  if player and enemy:
    var distance_to_player := enemy.global_position.distance_to(player.global_position)
    var direction_to_player := enemy.global_position.direction_to(player.global_position)
    enemy.velocity = direction_to_player.normalized() * enemy.speed
    enemy.move_and_slide()

    if distance_to_player > attack_range:
      transition_to.emit(self, "chase")

func _on_animated_sprite_2d_frame_changed() -> void:
  var start_frame := 8
  var end_frame := 8

  if sprite.frame >= start_frame and sprite.frame <= end_frame:
    hitbox_collision.call_deferred("set", "disabled", false)
  else:
    hitbox_collision.call_deferred("set", "disabled", true)

func _on_hurt_box_hurt(damage: int) -> void:
  enemy.health_points -= damage
  if enemy.health_points <= 0:
    transition_to.emit(self, "death")
  else:
    transition_to.emit(self, "hurt")
