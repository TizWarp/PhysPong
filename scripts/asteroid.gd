extends RigidBody2D

var alpha = Color(0,0,0,5)
var spawn_locations = [Vector2(-2000,-1000),Vector2(-2000,1000),Vector2(2000,-1000),Vector2(2000,1000)]
var colors = ["Red","Blue","Green","Yellow"]
@onready var sprite =  get_node("Sprite2D")
@onready var partic = get_node("CPUParticles2D")
@onready var explosion = preload("res://scenes/explosion.tscn")

func _ready():
	position = spawn_locations[randi_range(0,(spawn_locations.size()-1))] + Vector2(randi_range(-100,100),randi_range(-100,100))
	look_at(Vector2(randi_range(-400,400),randi_range(-400,400)))
	linear_velocity = Vector2(300,0).rotated(rotation)
	angular_velocity = randi_range(-20,20)
	modulate = GameVars.color_index[colors[randi_range(0,3)]]
	modulate.a = alpha.a
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	GameVars.asteroid_count -= 1
	queue_free()

func spawn_explosion():
	var instance = explosion.instantiate()
	instance.position = position
	instance.emitting =  true
	print("making explosion")
	get_parent().call_deferred("add_child",instance)

func _on_body_entered(body):
	spawn_explosion()
