extends State

@export var enemy: CharacterBody2D
@onready var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D

var player: CharacterBody2D

func _enter() -> void:
  sprite.play("chase")
  player = get_tree().get_first_node_in_group("player")

func _physics_update(_delta: float) -> void:
  if player and enemy:
    var direction := enemy.global_position.direction_to(player.global_position)
    enemy.velocity = direction.normalized() * enemy.speed

    update_sprite_orientation(direction)
    check_to_attack()
    enemy.move_and_slide()

func check_to_attack() -> void:
  var distance_to_player = enemy.global_position.distance_to(player.global_position)
  if distance_to_player <= enemy.attack_strategy.attack_range:
    transition_to.emit(self, "attack")

func update_sprite_orientation(to_player: Vector2) -> void:
  if to_player.x < 0:
    sprite.flip_h = true
  else:
    sprite.flip_h = false
