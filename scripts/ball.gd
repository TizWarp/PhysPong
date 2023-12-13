extends RigidBody2D

var reset_to = Vector2(0,0)
var last_hit = null
var last_hit_score = 0
var messages = ["Get Recked", "SCORE", "Owned", "Destroyed", "+1", "Another one", "Get Gud", "Ouch", "Rent Free", "Unstopable", "Smashed"]

@onready var animations = get_node("AnimationPlayer")
@onready var explosion = preload("res://scenes/explosion.tscn")
@onready var collision = get_node("CollisionShape2D")
@onready var hit_player = get_node("hit_player")
@onready var serve_player = get_node("server_player")
@onready var shift_player = get_node("AnimationPlayer2")

func _ready():
	animations.play("spawn")
	Signals.connect("player1_scored",player1_scored)
	Signals.connect("player2_scored",player2_scored)
	position = Vector2(-800,0)

func _integrate_forces(state):
	
	GameVars.ball_pos = position
	
	if reset_to != Vector2(0,0):
		state.transform.origin = reset_to
		linear_velocity = Vector2(0,0)
		angular_velocity = 0
		reset_to = Vector2(0,0)
		shift_player.stop()
		animations.play("spawn")
		
	#apply_torque(10000)
	
func player2_scored():
	reset_to = Vector2(800,0)
	collision.set_deferred("disabled",true)
	get_parent().get_parent().spawn_message(messages[randi_range(0,messages.size()-1)],0.7, last_hit)
	
func player1_scored():
	reset_to = Vector2(-800,0)
	collision.set_deferred("disabled",true)	
	get_parent().get_parent().spawn_message(messages[randi_range(0,messages.size()-1)],0.7,last_hit)
	

func spawn_explosion():
	var instance = explosion.instantiate()
	instance.position = position
	instance.emitting =  true
	print("making explosion")
	get_parent().call_deferred("add_child",instance)

func _on_body_entered(body):
	spawn_explosion()
	hit_player.playing = true
	if body.name == str(0):
		last_hit = GameVars.player1color
	if body.name == str(1):
		last_hit = GameVars.player2color
	if body.name == str(2):
		last_hit = GameVars.player3color
	if body.name == str(3):
		last_hit = GameVars.player4color
		


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "spawn":
		spawn_explosion()
		hit_player.playing = true
		collision.set_deferred("disabled",false)
		shift_player.play("color_shift")		
