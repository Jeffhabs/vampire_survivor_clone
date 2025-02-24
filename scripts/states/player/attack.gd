class_name PlayerAttack
extends State

@export var player: Player
@export var speed := 65.0
@onready var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter():
  sprite.play("attack")

func _exit():
  pass

func _update(_delta: float):
  pass

func _physics_update(_delta: float):
  player.move_player()


func _on_animated_sprite_2d_animation_finished() -> void:
  if sprite.animation == "attack":
    transition_to.emit(self, "idle")
