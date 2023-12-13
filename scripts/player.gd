extends RigidBody2D

@export var player_input = 0 
@export var player_index = 0

var up_speed = 40000
var side_speed = 19500
var bar_visible = false
var big = false
@onready var boost_bar = get_node("ProgressBar")
@onready var sprite = get_node("Sprite2D")
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var particle = get_node("GPUParticles2D")
@onready var animations = get_node("AnimationPlayer")
var boost = 100
var old_grav
var gravity_flipped = false

func _process(delta):
	boost_bar.set_deferred("value",boost)
	if gravity_scale == -1:
		particle.gravity = Vector2(0,-980)
	elif gravity_scale == 1:
		particle.gravity = Vector2(0,980)
		
func _ready():
	Signals.connect("player_disconnected",player_disconnected)
	Signals.connect("flip_gravity",flip_gravity)
	Signals.connect("reset_game",reset_game)
	
	match player_index:
		
		0:
			sprite.modulate = GameVars.color_index[GameVars.player1color]
			particle.color = GameVars.color_index[GameVars.player1color]
		1:
			sprite.modulate = GameVars.color_index[GameVars.player2color]
			particle.color = GameVars.color_index[GameVars.player2color]
		2:
			sprite.modulate = GameVars.color_index[GameVars.player3color]
			particle.color = GameVars.color_index[GameVars.player3color]
		3:
			sprite.modulate = GameVars.color_index[GameVars.player4color]
			particle.color = GameVars.color_index[GameVars.player4color]



func _physics_process(delta):
	
	match player_input:
		
		
		0:
	
			apply_central_force(Vector2(side_speed,0)*Input.get_joy_axis(0,JOY_AXIS_LEFT_X))
			apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(0,JOY_AXIS_LEFT_Y))
						
			if Input.is_action_pressed("space") and boost > 0:
				apply_central_force(Vector2(up_speed*2,0)*Input.get_joy_axis(0,JOY_AXIS_LEFT_X))
				apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(0,JOY_AXIS_LEFT_Y))
				boost = clamp(boost-3,0,100)
			elif !Input.is_action_pressed("space"):
				boost = clamp(boost+0.5,0,100)
				
			if Input.get_joy_axis(0,JOY_AXIS_TRIGGER_RIGHT) and boost > 0:
				apply_central_force(Vector2(up_speed*2,0)*Input.get_joy_axis(0,JOY_AXIS_LEFT_X))
				apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(0,JOY_AXIS_LEFT_Y))
				boost = clamp(boost-3,0,100)
			elif !Input.get_joy_axis(0,JOY_AXIS_TRIGGER_RIGHT):
				boost = clamp(boost+0.5,0,100)

		1:

			apply_central_force(Vector2(side_speed,0)*Input.get_joy_axis(1,JOY_AXIS_LEFT_X))
			apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(1,JOY_AXIS_LEFT_Y))
			
			if Input.get_joy_axis(1,JOY_AXIS_TRIGGER_RIGHT) and boost > 0:
				apply_central_force(Vector2(up_speed*2,0)*Input.get_joy_axis(1,JOY_AXIS_LEFT_X))
				apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(1,JOY_AXIS_LEFT_Y))
				boost = clamp(boost-3,0,100)
			elif !Input.get_joy_axis(1,JOY_AXIS_TRIGGER_RIGHT):
				boost = clamp(boost+0.5,0,100)
				
		2:

			apply_central_force(Vector2(side_speed,0)*Input.get_joy_axis(2,JOY_AXIS_LEFT_X))
			apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(2,JOY_AXIS_LEFT_Y))

			if Input.get_joy_axis(2,JOY_AXIS_TRIGGER_RIGHT) and boost > 0:
				apply_central_force(Vector2(up_speed*2,0)*Input.get_joy_axis(2,JOY_AXIS_LEFT_X))
				apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(2,JOY_AXIS_LEFT_Y))
				boost = clamp(boost-3,0,100)
			elif !Input.get_joy_axis(2,JOY_AXIS_TRIGGER_RIGHT):
				boost = clamp(boost+0.5,0,100)
				
		3:

			apply_central_force(Vector2(side_speed,0)*Input.get_joy_axis(3,JOY_AXIS_LEFT_X))
			apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(3,JOY_AXIS_LEFT_Y))
			
			if Input.get_joy_axis(3,JOY_AXIS_TRIGGER_RIGHT) and boost > 0:
				apply_central_force(Vector2(up_speed*2,0)*Input.get_joy_axis(3,JOY_AXIS_LEFT_X))
				apply_central_force(Vector2(0,up_speed)*Input.get_joy_axis(3,JOY_AXIS_LEFT_Y))
				boost = clamp(boost-3,0,100)
			elif !Input.get_joy_axis(3,JOY_AXIS_TRIGGER_RIGHT):
				boost = clamp(boost+0.5,0,100)
				
		4:
			if Input.is_action_pressed("w"):
				apply_central_force(Vector2(0,-up_speed))
			if Input.is_action_pressed("s"):
				apply_central_force(Vector2(0,up_speed))
			if Input.is_action_pressed("a"):
				apply_central_force(Vector2(-side_speed,0))
			if Input.is_action_pressed("d"):
				apply_central_force(Vector2(side_speed,0))
				
			if Input.is_action_pressed("space") and boost > 0:
				side_speed = 40000*1.5
				up_speed = 40000*2.5
				boost = clamp(boost-3,0,100)
			elif !Input.is_action_pressed("space"):
				boost = clamp(boost+0.5,0,100)
				up_speed = 40000
				side_speed = 19500
func player_disconnected(player_id):
	if name == str(player_id):
		self.queue_free()
	
		
func flip_gravity():
	print("flipping gravity")
	gravity_scale = gravity_scale * -1


	

func _on_progress_bar_value_changed(value):
	if value < 100 and !bar_visible:
		animations.play("fade_bar_in")
		bar_visible = true
	if value == 100 and bar_visible:
		animations.play("fade_bar_out")
		bar_visible = false
		
func reset_game():
	queue_free()
