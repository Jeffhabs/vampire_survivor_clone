class_name FireballStrategy
extends BaseProjectileStrategy

var fireball_scene = preload("res://entities/projectiles/fireball/fireball.tscn")

var ammo := 0
var base_ammo := 1
var reload_timer: Timer
var attack_timer: Timer
var nearest_enemies: Array = []

@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var player_sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D

signal attack_started()

func _init(new_level: int) -> void:
  level = new_level

func _ready() -> void:
  super._ready()
  player.nearest_enemies_detected.connect(update_nearest_enemies)

  reload_timer = Timer.new()
  # reload_timer.wait_time = 1.5
  reload_timer.wait_time = 2.5
  reload_timer.timeout.connect(_on_reload_timer_timeout)
  add_child(reload_timer)

  attack_timer = Timer.new()
  # attack_timer.wait_time = 0.075
  attack_timer.wait_time = .5
  attack_timer.timeout.connect(_on_attack_timer_timeout)
  add_child(attack_timer)

func update_nearest_enemies(enemies: Array) -> void:
  nearest_enemies = enemies
  if nearest_enemies.size() > 0:
    if reload_timer.is_stopped():
      reload_timer.start()
  else:
    reload_timer.stop()
    attack_timer.stop()

func _initialize() -> void:
  speed = 100
  lifetime = 15.0
  damage = 2
  interval = 1.5
  base_ammo = 1

func _process(delta: float) -> void:
  super._process(delta)

func _fire_projectile() -> void:
  var fireball: Fireball = fireball_scene.instantiate()
  fireball.position = Vector2(player.position.x, player.position.y - 10)
  fireball.speed = speed
  fireball.damage = damage
  fireball.target = get_closest_target()
  player.get_parent().add_child(fireball)
  setup_lifetime_timer(fireball)

func _apply_effects(_delta: float) -> void:
  # TODO: apply some cool effects like burn dmg?
  pass

func setup_lifetime_timer(fireball: Fireball) -> void:
  var lifetime_timer = Timer.new()
  lifetime_timer.wait_time = lifetime
  lifetime_timer.autostart = true
  lifetime_timer.timeout.connect(on_fireball_timeout.bind(fireball))
  add_child(lifetime_timer)

func on_fireball_timeout(fireball) -> void:
  if is_instance_valid(fireball):
    fireball.get_parent().remove_child(fireball)
    fireball.queue_free()

func _on_reload_timer_timeout():
  ammo += base_ammo
  attack_started.emit()
  attack_timer.start()

func _on_attack_timer_timeout():
  if ammo > 0:
    _fire_projectile()
    ammo -= 1
    attack_timer.start()
  else:
    attack_timer.stop()

func get_closest_target() -> Vector2:
  if nearest_enemies.size() > 0:
    var closest_enemy = nearest_enemies[0]
    var closest_distance = player.position.distance_to(closest_enemy.global_position)
    for enemy in nearest_enemies:
      var distance = player.position.distance_to(enemy.global_position)
      if distance < closest_distance:
        closest_enemy = enemy
        closest_distance = distance
    return closest_enemy.global_position
  else:
    return Vector2.UP
