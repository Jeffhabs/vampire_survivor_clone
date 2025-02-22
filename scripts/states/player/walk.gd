class_name PlayerWalk
extends State

@export var player: Player
@export var speed := 65.0
@onready var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter() -> void:
  sprite.play("walk")

func _physics_update(_delta: float) -> void:
  get_input()
  sprite.flip_h = player.velocity.x < 0
  player.move_and_slide()
  if player.velocity == Vector2.ZERO:
    transition_to.emit(self, "idle")

func get_input() -> void:
  var input_direction = Input.get_vector("left", "right", "up", "down")
  player.velocity = input_direction * speed


func _on_hurt_box_hurt(damage: int) -> void:
  player.health_points -= damage
  if player.health_points <= 0:
    # transition_to.emit(self, "death")
    print('player died')
  else:
    transition_to.emit(self, "hurt")
