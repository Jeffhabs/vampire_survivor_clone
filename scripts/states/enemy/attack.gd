class_name EnemyAttack
extends State

@export var enemy: CharacterBody2D
@export var attack_range := 50.0
@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D

var player: CharacterBody2D
var attack_timer: Timer

func _enter() -> void:
  sprite.play("attack")
  player = get_tree().get_first_node_in_group("player") as CharacterBody2D

func _physics_update(_delta: float) -> void:
  if player and enemy:
    var distance_to_player := enemy.global_position.distance_to(player.global_position)
    var direction_to_player := enemy.global_position.direction_to(player.global_position)
    enemy.velocity = direction_to_player.normalized() * enemy.speed
    enemy.move_and_slide()

    if distance_to_player > attack_range:
      transition_to.emit(self, "chase")