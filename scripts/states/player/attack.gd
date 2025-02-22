class_name PlayerAttack
extends State

@export var player: Player
@export var speed := 65.0
@onready var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter():
  sprite.flip_h = player.last_facing_left
  sprite.play("attack")

func _exit():
  pass

func _update(_delta: float):
  pass

func _physics_update(_delta: float):
  move_player()

func move_player() -> void:
  var input_direction = Input.get_vector("left", "right", "up", "down")
  player.velocity = input_direction * speed
  if player.velocity.x != 0:
    player.last_facing_left = player.velocity.x < 0
  sprite.flip_h = player.last_facing_left
  player.move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
  if sprite.animation == "attack":
    transition_to.emit(self, "idle")
