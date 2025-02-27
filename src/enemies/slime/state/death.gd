extends State

@export var enemy: CharacterBody2D
@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter() -> void:
  sprite.play("death")

func _physics_update(_delta: float) -> void:
  enemy.velocity = Vector2.ZERO


func _on_animated_sprite_2d_animation_finished() -> void:
  if sprite.animation == "death":
    get_tree().create_timer(1).timeout.connect(enemy.queue_free)
