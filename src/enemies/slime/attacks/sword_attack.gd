extends AttackStrategy

@onready var hitbox := $HitBox
@onready var hitbox_collision := $HitBox/CollisionShape2D
@onready var player := get_tree().get_first_node_in_group("player")
@export var sprite: AnimatedSprite2D

var initial_collision_position := Vector2(0, 0)
var initial_collision_rotation := 0

func _ready() -> void:
  hitbox.damage = damage
  initial_collision_position = hitbox_collision.position
  initial_collision_rotation = hitbox_collision.rotation_degrees

func _physics_process(_delta: float) -> void:
  var direction := global_position.direction_to(player.global_position)
  update_hitbox_orientation(direction)

func update_hitbox_orientation(to_player: Vector2) -> void:
  if to_player.x < 0:
    sprite.flip_h = true
    hitbox_collision.position.x = - initial_collision_position.x
  else:
    sprite.flip_h = false
    hitbox_collision.position.x = initial_collision_position.x

  if to_player.y < 0:
    hitbox_collision.position.y = - initial_collision_position.y
  else:
    hitbox_collision.position.y = initial_collision_position.y

  # player is top right
  if to_player.x > 0 and to_player.y < 0:
    hitbox_collision.rotation_degrees = - initial_collision_rotation
  # player is top left
  if to_player.x < 0 and to_player.y < 0:
    hitbox_collision.rotation_degrees = initial_collision_rotation
  # player is bottom right
  if to_player.x > 0 and to_player.y > 0:
    hitbox_collision.rotation_degrees = initial_collision_rotation
  # player is bottom left
  if to_player.x < 0 and to_player.y > 0:
    hitbox_collision.rotation_degrees = - initial_collision_rotation

func _play_animation() -> void:
  sprite.play(animation_name)

func _attack() -> void:
  if sprite.animation != animation_name:
    return

  if sprite.frame == attack_start_frame and sprite.frame <= attack_end_frame:
    if hitbox_collision.disabled:
      hitbox_collision.call_deferred("set", "disabled", false)
  else:
    if not hitbox_collision.disabled:
      hitbox_collision.call_deferred("set", "disabled", true)