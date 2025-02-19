class_name BaseProjectileStrategy
extends Area2D

# TODO: audit these variables
var speed: float
var interval: float = 2.0
var damage := 5
var direction: Vector2
var lifetime: float
# var timer: Timer
var target := Vector2.ZERO
var angel = Vector2.ZERO
var level := 0

func _ready() -> void:
  _initialize()
  # timer = Timer.new()
  # timer.wait_time = interval
  # timer.autostart = true
  # timer.timeout.connect(_fire_projectile)
  # add_child(timer)

func _process(delta: float) -> void:
  _apply_effects(delta)

# Methods to override in child classes
func _fire_projectile() -> void:
  pass

func _initialize() -> void:
  pass

func _apply_effects(_delta: float) -> void:
  pass
