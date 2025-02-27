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

  # if to_player.y < 0:
  #   hitbox_collision.position.y = - initial_collision_position.y
  # else:
  #   hitbox_collision.position.y = initial_collision_position.y


func _play_animation() -> void:
  sprite.play(animation_name)

func _attack() -> void:
  if sprite.animation != animation_name:
    return

  var start_frame := 4
  var end_frame := 4

  if sprite.frame >= start_frame and sprite.frame <= end_frame:
    hitbox_collision.call_deferred("set", "disabled", false)
  else:
    hitbox_collision.call_deferred("set", "disabled", true)