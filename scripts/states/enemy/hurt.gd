extends State

@export var enemy: CharacterBody2D
@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D

func _enter():
  sprite.play("hurt")

func _physics_update(_delta: float):
  enemy.velocity = Vector2.ZERO