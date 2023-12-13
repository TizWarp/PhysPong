extends CharacterBody2D

@onready var sprite = get_node("Sprite2D")

@onready var explosion = preload("res://scenes/explosion.tscn")

@export var player_input = 0
@export var player_index = 0

func _ready():
	Signals.connect("cursor_disconnected",cursor_disconnected)
	spawn_explosion()
	
func _process(delta):
	
	
	if GameVars.in_game:
		queue_free()
	
	match player_index:
		
		0:
			sprite.self_modulate = GameVars.color_index[GameVars.player1color]
		1:
			sprite.self_modulate = GameVars.color_index[GameVars.player2color]
		2:
			sprite.self_modulate = GameVars.color_index[GameVars.player3color]
		3:
			sprite.self_modulate = GameVars.color_index[GameVars.player4color]
	
	match player_input:
		
		0:
			if abs(Input.get_joy_axis(0,JOY_AXIS_LEFT_X)) > 0.3 or abs(Input.get_joy_axis(0,JOY_AXIS_LEFT_Y)) > 0.3:
				velocity = Vector2(1000*Input.get_joy_axis(0,JOY_AXIS_LEFT_X),1000*Input.get_joy_axis(0,JOY_AXIS_LEFT_Y))
			
		1:
			if abs(Input.get_joy_axis(1,JOY_AXIS_LEFT_X)) > 0.3 or abs(Input.get_joy_axis(1,JOY_AXIS_LEFT_Y)) > 0.3:
				velocity = Vector2(1000*Input.get_joy_axis(1,JOY_AXIS_LEFT_X),1000*Input.get_joy_axis(1,JOY_AXIS_LEFT_Y))
			
		2:
			if abs(Input.get_joy_axis(2,JOY_AXIS_LEFT_X)) > 0.3 or abs(Input.get_joy_axis(2,JOY_AXIS_LEFT_Y)) > 0.3:
				velocity = Vector2(1000*Input.get_joy_axis(2,JOY_AXIS_LEFT_X),1000*Input.get_joy_axis(2,JOY_AXIS_LEFT_Y))
			
		3:
			if abs(Input.get_joy_axis(3,JOY_AXIS_LEFT_X)) > 0.3 or abs(Input.get_joy_axis(3,JOY_AXIS_LEFT_Y)) > 0.3:
				velocity = Vector2(1000*Input.get_joy_axis(3,JOY_AXIS_LEFT_X),1000*Input.get_joy_axis(3,JOY_AXIS_LEFT_Y))
		4:
			if Input.is_action_pressed("w"):
				velocity += Vector2(0,-750)
			if Input.is_action_pressed("s"):
				velocity += Vector2(0,750)	
			if Input.is_action_pressed("a"):
				velocity += Vector2(-750,0)	
			if Input.is_action_pressed("d"):
				velocity += Vector2(750,0)	
	move_and_slide()
	velocity = Vector2(0,0)

func spawn_explosion():
	var instance = explosion.instantiate()
	instance.position = position
	instance.emitting =  true
	print("making explosion")
	get_parent().call_deferred("add_child",instance)

func cursor_disconnected(player):
	if str(player) in name:
		self.queue_free()
