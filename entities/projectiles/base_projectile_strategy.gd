class_name BaseProjectileStrategy
extends Area2D

# TODO: audit these variables
@export var speed: float
@export var interval: float = 2.0
@export var damage := 5
@export var direction: Vector2
@export var lifetime: float
@export var target := Vector2.ZERO
@export var angel = Vector2.ZERO
@export var level := 1

func _ready() -> void:
  _initialize()

func _process(delta: float) -> void:
  _apply_effects(delta)

# Methods to override in child classes
func _fire_projectile() -> void:
  pass

func _initialize() -> void:
  pass

func _apply_effects(_delta: float) -> void:
  pass
