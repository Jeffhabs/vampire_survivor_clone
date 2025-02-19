class_name Player
extends CharacterBody2D

var speed := 65.0
var health_points := 100
var direction := Vector2.RIGHT
var nearest_enemies: Array = []

@onready var _character_sprite = $AnimatedSprite2D
@onready var projectile_manager = $ProjectileManager

signal nearest_enemies_detected(enemies: Array)

func _ready() -> void:
  projectile_manager.add_projectile("fireball")

func _physics_process(_delta: float) -> void:
  get_input()
  move_and_slide()
  handle_animation()

func get_input() -> void:
  var input_direction = Input.get_vector("left", "right", "up", "down")

  if Input.is_action_pressed("down") and Input.is_action_pressed("left"):
    direction = Vector2(-1, 1)
  elif Input.is_action_pressed("down") and Input.is_action_pressed("right"):
    direction = Vector2(1, 1)
  elif Input.is_action_pressed("up") and Input.is_action_pressed("left"):
    direction = Vector2(-1, -1)
  elif Input.is_action_pressed("up") and Input.is_action_pressed("right"):
    direction = Vector2(1, -1)
  elif Input.is_action_pressed("right"):
    direction = Vector2.RIGHT
  elif Input.is_action_pressed("left"):
    direction = Vector2.LEFT
  elif Input.is_action_pressed("up"):
    direction = Vector2.UP
  elif Input.is_action_pressed("down"):
    direction = Vector2.DOWN

  velocity = input_direction * speed

func handle_animation() -> void:
  if velocity != Vector2.ZERO:
    _character_sprite.play("walk")
    _character_sprite.flip_h = velocity.x < 0
  else:
    _character_sprite.play("idle")

func _on_hurt_box_hurt(damage: int) -> void:
  health_points -= damage
  print("Player health: %d" % health_points)


func _on_enemy_detection_area_body_entered(body: Node2D) -> void:
  if not nearest_enemies.has(body):
    nearest_enemies.append(body)
    nearest_enemies_detected.emit(nearest_enemies)

func _on_enemy_detection_area_body_exited(body: Node2D) -> void:
  if nearest_enemies.has(body):
    nearest_enemies.erase(body)
    nearest_enemies_detected.emit(nearest_enemies)
