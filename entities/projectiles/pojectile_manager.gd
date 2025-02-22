class_name ProjectileManager
extends Node

@onready var player := get_tree().get_first_node_in_group("player") as Player

var strategy_classes: Dictionary = {
  "fireball": FireballStrategy,
}

func _ready() -> void:
  pass
  # add_projectile("fireball")

# equivalent to set_strategy
func add_projectile(projectile_name: String) -> void:
  if strategy_classes.has(projectile_name):
    var strategy_class = strategy_classes[projectile_name]
    var strategy_instance = strategy_class.new(1)
    strategy_instance.attack_started.connect(_on_attack_started)
    add_child(strategy_instance)
  else:
    print("Invalid projectile strategy.")

func _on_attack_started() -> void:
  player.transition_to_attack()
