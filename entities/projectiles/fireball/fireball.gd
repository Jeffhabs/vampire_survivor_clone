class_name Fireball
extends Area2D

var speed: float = 110.0
var target := Vector2.ZERO
var damage := 1
var angle := Vector2.ZERO

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _hit_box = $HitBox
@onready var _base_collision = $CollisionShape2D

func _ready() -> void:
  _hit_box.damage = damage
  angle = global_position.direction_to(target)
  rotation = angle.angle()
  _animated_sprite.play("travel")

func _physics_process(delta: float) -> void:
  position += angle * speed * delta

func _on_hit_box_area_entered(area: Area2D) -> void:
  if area.is_in_group("enemy"):
    _hit_box.get_node("CollisionShape2D").call_deferred("set", "disabled", true)
    _base_collision.call_deferred("set", "disabled", true)
    _animated_sprite.play("impact")
    get_tree().create_timer(0.5).timeout.connect(queue_free)
