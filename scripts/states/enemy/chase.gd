class_name EnemyChase
extends State

@export var enemy: CharacterBody2D
@export var attack_range := 58.0

@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D
@onready var hitbox_collision := enemy.get_node("HitBox/CollisionShape2D") as CollisionShape2D

var player: CharacterBody2D

func _enter() -> void:
  hitbox_collision.disabled = true
  sprite.play("chase")
  player = get_tree().get_first_node_in_group("player") as CharacterBody2D

func _physics_update(_delta: float) -> void:
  if player and enemy:
    var direction := enemy.global_position.direction_to(player.global_position)
    enemy.velocity = direction.normalized() * enemy.speed

    update_sprite_orientation(direction)
    check_to_attack()
    enemy.move_and_slide()

func check_to_attack() -> void:
  if enemy.global_position.distance_to(player.global_position) <= attack_range:
    transition_to.emit(self, "attack")

func update_sprite_orientation(to_player: Vector2) -> void:
  if to_player.x < 0:
    sprite.flip_h = true
  else:
    sprite.flip_h = false

func _on_hurt_box_hurt(damage: int) -> void:
  enemy.health_points -= damage
  if enemy.health_points <= 0:
    transition_to.emit(self, "death")
  else:
    transition_to.emit(self, "hurt")
