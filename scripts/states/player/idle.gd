class_name PlayerIdle
extends State

@export var player: Player
@onready var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter() -> void:
  sprite.flip_h = player.last_facing_left
  sprite.play("idle")

func _physics_update(_delta: float) -> void:
  if player.velocity != Vector2.ZERO:
    transition_to.emit(self, "walk")

func _on_player_attack_started() -> void:
  transition_to.emit(self, "attack")
