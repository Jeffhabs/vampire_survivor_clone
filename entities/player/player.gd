class_name Player
extends CharacterBody2D

var speed := 65.0
var health_points := 100
var direction := Vector2.RIGHT
var nearest_enemies: Array = []

@onready var projectile_manager = $ProjectileManager

signal nearest_enemies_detected(enemies: Array)

func _ready() -> void:
  projectile_manager.add_projectile("fireball")

func _physics_process(_delta: float) -> void:
  pass

func _on_enemy_detection_area_body_entered(body: Node2D) -> void:
  if not nearest_enemies.has(body):
    nearest_enemies.append(body)
    nearest_enemies_detected.emit(nearest_enemies)

func _on_enemy_detection_area_body_exited(body: Node2D) -> void:
  if nearest_enemies.has(body):
    nearest_enemies.erase(body)
    nearest_enemies_detected.emit(nearest_enemies)
