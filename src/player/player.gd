class_name Player
extends CharacterBody2D

var speed := 55.0
var health_points := 100
var nearest_enemies: Array = []
var last_facing_left: bool = false

@onready var projectile_manager = $ProjectileManager
@onready var state_machine = $StateMachine
@onready var sprite := $AnimatedSprite2D

signal nearest_enemies_detected(enemies: Array)

func _ready() -> void:
  # projectile_manager.add_projectile("fireball")
  pass

func _physics_process(_delta: float) -> void:
  move_player()

func _on_enemy_detection_area_body_entered(body: Node2D) -> void:
  if not nearest_enemies.has(body):
    nearest_enemies.append(body)
    nearest_enemies_detected.emit(nearest_enemies)

func _on_enemy_detection_area_body_exited(body: Node2D) -> void:
  if nearest_enemies.has(body):
    nearest_enemies.erase(body)
    nearest_enemies_detected.emit(nearest_enemies)

func _on_hurt_box_hurt(damage: int) -> void:
  health_points -= damage
  print(health_points)
  if health_points <= 0:
    # state_machine.transition_to("death")
    pass
  else:
    state_machine.transition_to("hurt")

func move_player() -> void:
  var input_direction = Input.get_vector("left", "right", "up", "down")
  velocity = input_direction * speed
  update_facing_direction()
  move_and_slide()

func update_facing_direction() -> void:
  if velocity.x != 0:
    last_facing_left = velocity.x < 0

  sprite.flip_h = last_facing_left