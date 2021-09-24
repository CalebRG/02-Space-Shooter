extends KinematicBody2D

var VP = Vector2.ZERO
var direction = 0.0
var dir_speed = 0.01
onready var player = get_node("/root/Game/Players/Player")
onready var players = get_node("/root/Game/Players")
var move = Vector2.ZERO
var speed = 1

var probability = 0.6

var Bullets = null
var Enemy_Bullet = preload("res://Enemy_Bullet/Enemy_Bullet.tscn")

var Explosion = preload("res://Explosion/Explosion_ship.tscn")
var Explosions = null

var points = 10


func _ready():
	randomize()

func _physics_process(_delta):
	if player != null:
		var flyto = player.global_position - global_position
		flyto = flyto.normalized()
		global_rotation = atan2(flyto.y, flyto.x) + 90
		move_and_collide(flyto * speed)
		
func die():
	if Global.has_method("update_score"):
		Global.update_score(points)
	if Explosions == null:
		Explosions = get_node_or_null("/root/Game/Explosions")
	if Explosions != null:
		var explosion = Explosion.instance()
		explosion.position = position
		Explosions.add_child(explosion)
	queue_free()


func _on_Timer_timeout():
	if Bullets == null:
		Bullets = get_node("/root/Game/Bullets")
	if Bullets != null and randf() < probability:
		var bullet = Enemy_Bullet.instance()
		bullet.position = position + Vector2(0,-10).rotated(direction)
		bullet.rotation = global_rotation
		Bullets.add_child(bullet) 



