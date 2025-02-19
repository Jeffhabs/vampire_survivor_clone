extends Node2D

@export var spawns := [] as Array[SpawnInfo]
@onready var player := get_tree().get_first_node_in_group("player")

var total_enemy_count := 0
var spawn_delay := 0
func _on_timer_timeout() -> void:
  for spawn in spawns:
    if spawn_delay < spawn.spawn_interval:
      spawn_delay += 1
    else:
      spawn.spawn_delay_counter = 0
      var new_enemy = load(str(spawn.enemey.resource_path))
      var counter := 0
      while counter < spawn.enemy_count and total_enemy_count < spawn.enemy_limit:
        var enemy_spawn = new_enemy.instantiate()
        enemy_spawn.global_position = get_random_position()
        player.get_parent().add_child(enemy_spawn)
        total_enemy_count += 1
        counter += 1

func get_random_position() -> Vector2:
  var view_port = get_viewport_rect().size * randf_range(1.1,1.4)
  var top_left := Vector2(player.global_position.x - view_port.x/2, player.global_position.y - view_port.y/2)
  var top_right := Vector2(player.global_position.x + view_port.x/2, player.global_position.y - view_port.y/2)
  var bottom_left := Vector2(player.global_position.x - view_port.x/2, player.global_position.y + view_port.y/2)
  var bottom_right := Vector2(player.global_position.x + view_port.x/2, player.global_position.y + view_port.y/2)

  var pos_side = ["up", "down", "right", "left"].pick_random()
  var spawn_pos1 := Vector2.ZERO
  var spawn_pos2 := Vector2.ZERO

  match pos_side:
    "up":
      spawn_pos1 = top_left
      spawn_pos2 = top_right
    "down":
      spawn_pos1 = bottom_left
      spawn_pos2 = bottom_right
    "right":
      spawn_pos1 = top_right
      spawn_pos2 = bottom_right
    "left":
      spawn_pos1 = top_left
      spawn_pos2 = bottom_left

  var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
  var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)

  return Vector2(x_spawn, y_spawn)
