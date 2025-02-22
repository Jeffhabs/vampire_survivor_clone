extends CharacterBody2D

# TODO: set this up to use an enemy resource with stats etc

@onready var player := get_tree().get_first_node_in_group("player")
@onready var sprite := $AnimatedSprite2D
@onready var hitbox_collision := $HitBox/CollisionShape2D

var speed := 20.0
var health_points := 10
var initial_collision_position := Vector2(0, 0)
var initial_collision_rotation := 0

func _ready() -> void:
  initial_collision_position = hitbox_collision.position
  initial_collision_rotation = hitbox_collision.rotation_degrees

func _physics_process(_delta: float) -> void:
  var direction := global_position.direction_to(player.global_position)
  update_sprite_orientation(direction)

func update_sprite_orientation(to_player: Vector2) -> void:
  if to_player.x < 0:
    sprite.flip_h = true
    hitbox_collision.position.x = -initial_collision_position.x
  else:
    sprite.flip_h = false
    hitbox_collision.position.x = initial_collision_position.x

  if to_player.y < 0:
    hitbox_collision.position.y = -initial_collision_position.y
  else:
    hitbox_collision.position.y = initial_collision_position.y

  # player is top right
  if to_player.x > 0 and to_player.y < 0:
    hitbox_collision.rotation_degrees = -initial_collision_rotation
  # player is top left
  if to_player.x < 0 and to_player.y < 0:
    hitbox_collision.rotation_degrees = initial_collision_rotation
  # player is bottom right
  if to_player.x > 0 and to_player.y > 0:
    hitbox_collision.rotation_degrees = initial_collision_rotation
  # player is bottom left
  if to_player.x < 0 and to_player.y > 0:
    hitbox_collision.rotation_degrees = -initial_collision_rotation