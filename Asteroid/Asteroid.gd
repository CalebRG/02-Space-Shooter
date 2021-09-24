extends RigidBody2D

var screensize = Vector2.ZERO

var Asteroid_small = preload("res://Asteroid/Asteroid_small.tscn")
var Asteroids = null 
var Explosions = null
var Explosion = preload("res://Explosion/Explosion.tscn")
var points = 5



func _ready():
	screensize = get_viewport().size

func _integrate_forces(state):
	var t = state.get_transform()
	t.origin.x = wrapf(t.origin.x,0,screensize.x)
	t.origin.y = wrapf(t.origin.y,0,screensize.y)
	state.set_transform(t)

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
