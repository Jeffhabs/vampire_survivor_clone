extends CharacterBody2D
@onready var player := get_tree().get_first_node_in_group("player")
@onready var sprite := $AnimatedSprite2D

var speed := 20.0
var health_points := 10

func _ready() -> void:
  # sprite.play("walk")
  pass

func _physics_process(_delta: float) -> void:
  pass
  # var direction := global_position.direction_to(player.global_position)
  # velocity = direction.normalized() * speed
  # update_sprite_orientation(direction)
  # move_and_slide()

func update_sprite_orientation(to_player: Vector2) -> void:
  if to_player.x < 0:
    sprite.flip_h = true
  else:
    sprite.flip_h = false

func _on_hurt_box_hurt(damage: int) -> void:
    health_points -= damage
    sprite.play("hurt")
    if health_points <= 0:
      sprite.play("death")

func _on_animated_sprite_2d_frame_changed() -> void:
  if sprite.animation == "hurt" and sprite.frame == sprite.sprite_frames.get_frame_count("hurt") - 1:
    sprite.play("walk")

  if sprite.animation == "death" and sprite.frame == sprite.sprite_frames.get_frame_count("death") - 1:
    queue_free()
