class_name Player
extends CharacterBody2D

@export var speed := 45.0
var health_points := 100
var nearest_enemies: Array = []
var last_facing_left: bool = false

@onready var projectile_manager = $ProjectileManager
@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D

signal nearest_enemies_detected(enemies: Array)

func _ready() -> void:
  projectile_manager.add_projectile("fireball")

func _physics_process(_delta: float) -> void:
  pass

func move_player() -> void:
  var input_direction = Input.get_vector("left", "right", "up", "down")
  velocity = input_direction * speed
  update_facing_direction()
  move_and_slide()

func _on_enemy_detection_area_body_entered(body: Node2D) -> void:
  if not nearest_enemies.has(body):
    nearest_enemies.append(body)
    nearest_enemies_detected.emit(nearest_enemies)

func _on_enemy_detection_area_body_exited(body: Node2D) -> void:
  if nearest_enemies.has(body):
    nearest_enemies.erase(body)
    nearest_enemies_detected.emit(nearest_enemies)

func update_facing_direction() -> void:
  if velocity.x != 0:
    last_facing_left = velocity.x < 0

  sprite.flip_h = last_facing_left
