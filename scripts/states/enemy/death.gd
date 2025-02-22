class_name EnemyDeath
extends State

@export var enemy: CharacterBody2D
@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D

var player: CharacterBody2D

func _enter() -> void:
  sprite.play("death")

func _physics_update(_delta: float) -> void:
  enemy.velocity = Vector2.ZERO

func _on_animated_sprite_2d_frame_changed() -> void:
  if sprite.animation == "death" and sprite.frame == sprite.sprite_frames.get_frame_count("death") - 1:
    get_tree().create_timer(1).timeout.connect(defer_queue_free)

func defer_queue_free() -> void:
  enemy.call_deferred("queue_free")