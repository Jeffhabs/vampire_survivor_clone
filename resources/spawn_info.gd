class_name SpawnInfo
extends Resource

@export var time_start := 1
# TODO: change time_end to be like enemy_level or something
@export var time_end := 60
# FIXME: change this to be of type EnemyInfo (Resource) or EnemyStats
@export var enemey: Resource = null
@export var enemy_count := 2
# TODO: override enemy_limit based on the enemy_level
@export var enemy_limit := 20
@export var spawn_interval := 5.0
# TODO: not sure I need a spawn_delay_counter, I can just use local varirable in EnemySpawner.gd
@export var spawn_delay_counter := 0
