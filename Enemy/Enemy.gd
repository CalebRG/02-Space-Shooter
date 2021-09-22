extends KinematicBody2D

var VP = Vector2.ZERO
var direction = 0.0
var dir_speed = 0.01
var player = null
var move = Vector2.ZERO
var speed = 1

var probability = 0.6

var Bullets = null
var Enemy_Bullet = preload("res://Enemy_Bullet/Enemy_Bullet.tscn")

var Explosion = preload("res://Explosion/Explosion_ship.tscn")
var Explosions = null

var points = 10


func _ready():
	VP = get_viewport().size
	randomize()

func _physics_process(_delta):
	move = Vector2.ZERO
	
	if player != null:
		move = position.direction_to(player.position) * speed
	else:
		move = Vector2.ZERO
		
	move = move.normalized()
	move = move_and_collide(move)

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
		bullet.position = position + Vector2(0,-30).rotated(direction)
		bullet.rotation = direction
		Bullets.add_child(bullet) 



func _on_Area2D_body_entered(body):
	if body != self:
		player = body
	else:
		move = Vector2.ZERO


func _on_Area2D_body_exited(body):
	player = null
