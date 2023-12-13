extends Node2D

@onready var music = get_node("music")
@onready var message = get_node("message")
@onready var grav_type_input = get_node("Control/AspectRatioContainer/VBoxContainer/gavity_type")
@onready var game_cam = get_node("game_cam")
@onready var animations = get_node("AnimationPlayer")
@onready var player1scorelabel = get_node("game_stuff/RedScoreLabel")
@onready var player2scorelabel = get_node("game_stuff/BlueScoreLabel")
@onready var ball_scene = preload("res://scenes/ball.tscn")
@onready var player_scene = preload("res://scenes/player.tscn")
@onready var curosr_scene = preload("res://scenes/cursor.tscn")
@onready var flip_sound = get_node("flip_sound")
@onready var soccer_mode_input = get_node("Control/AspectRatioContainer/VBoxContainer/soccer_mode")
@onready var screen_shake_shader = get_node("shake_shader/Sprite2D")
@onready var asteroid_scene = preload("res://scenes/asteroid.tscn")
@onready var asteroid_timer = get_node("asteroid_timer")
@onready var asteroid_spawn = get_node("asteroids")
@onready var animation_shift = get_node("game_stuff/AnimationPlayer")
var next_flip = 5
var player1score = 0
var player2score = 0

func _process(delta):


	match GameVars.in_game:
		
		true:
			game_cam.position = GameVars.ball_pos/12
			music.volume_db = -7
		false:
			
			if Input.is_joy_button_pressed(0,JOY_BUTTON_A):
				if !GameVars.connected_players.has(0):
					GameVars.connected_players.append(0)
					Signals.emit_signal("player_joined")
				else:
					pass
			if Input.is_joy_button_pressed(1,JOY_BUTTON_A):
				if !GameVars.connected_players.has(1):
					GameVars.connected_players.append(1)
					Signals.emit_signal("player_joined")					
				else:
					pass
			if Input.is_joy_button_pressed(2,JOY_BUTTON_A):
				if !GameVars.connected_players.has(2):
					GameVars.connected_players.append(2)
					Signals.emit_signal("player_joined")					
				else:
					pass
			if Input.is_joy_button_pressed(3,JOY_BUTTON_A):
				if !GameVars.connected_players.has(3):
					GameVars.connected_players.append(3)
					Signals.emit_signal("player_joined")					
				else:
					pass
			if Input.is_action_just_pressed("space"):
				if !GameVars.connected_players.has(4):
					GameVars.connected_players.append(4)
					Signals.emit_signal("player_joined")					
				else:
					pass
			
			game_cam.position = Vector2(0,0)
			music.volume_db = -5
			
	GameVars.soccer_mode = soccer_mode_input.button_pressed

	
	if player1score >= GameVars.victory_score and GameVars.in_game:
		print("player1 wins")
		GameVars.in_game = false
		game_won("player1")
	if player2score >= GameVars.victory_score and GameVars.in_game:
		game_won("player2")
		GameVars.in_game = false
	
	player1scorelabel.text = str(player1score)
	player2scorelabel.text = str(player2score)

	if player1score + player2score == next_flip:
		next_flip += GameVars.flip_interval
		flip_gravity()

func flip_gravity():
	flip_sound.playing = true
	Signals.call_deferred("emit_signal","flip_gravity")

func _ready():

	animation_shift.play("shift_middle")

	game_cam.zoom = Vector2(1,1)

	#for i in Input.get_connected_joypads():
	#	spawn_cursor(i)
	
	music.playing = true
	
	$game_stuff.hide()
	
	Signals.connect("player_joined", player_joined)
	Signals.connect("player1_scored",player1_scored)
	Signals.connect("player2_scored",player2_scored)
	Input.connect("joy_connection_changed", controler_connection_changed)
	
	
func shake_screen(time, strength):
	screen_shake_shader.material.set_shader_parameter("ShakeStrength",strength)
	await get_tree().create_timer(time).timeout
	screen_shake_shader.material.set_shader_parameter("ShakeStrength",0)
	
	
func player1_scored():
	player1score += 1
	fade_scores()
	shake_screen(0.2,0.5)

	
func player2_scored():
	player2score += 1
	fade_scores()	
	shake_screen(0.2,0.5)
		
func spawn_cursor(player):
	var instance = curosr_scene.instantiate()
	var player_index = GameVars.connected_players.find(player)
	if player_index == 0:
		instance.position += Vector2(10,10)
		instance.player_index = player_index
		instance.player_input = player
		instance.position = Vector2(0,0)
		instance.name = str(player_index) + " cursor"
		call_deferred("add_child",instance)
	elif player_index == 1:
		instance.position += Vector2(10,10)		
		instance.player_index = player_index
		instance.player_input = player
		instance.position = Vector2(0,0)
		instance.name = str(player_index) + " cursor"
		call_deferred("add_child",instance)
	elif player_index == 2:
		instance.position += Vector2(10,10)
		instance.player_index = player_index
		instance.player_input = player
		instance.position = Vector2(0,0)
		instance.name = str(player_index) + " cursor"
		call_deferred("add_child",instance)
	elif player_index == 3:
		instance.position += Vector2(10,10)
		instance.player_index = player_index
		instance.player_input = player
		instance.position = Vector2(0,0)
		instance.name = str(player_index) + " cursor"	
		call_deferred("add_child",instance)
		

func spawn_player(player):
	var instance = player_scene.instantiate()
	var player_index = GameVars.connected_players.find(player)
	if player_index == 0:
		instance.player_input = player
		instance.player_index = player_index		
		instance.position = Vector2(-900,0)
		instance.name = str(player_index)
		call_deferred("add_child",instance)
	elif player_index == 1:
		instance.player_input = player
		instance.player_index = player_index		
		instance.position = Vector2(900,0)
		instance.name = str(player_index)
		call_deferred("add_child",instance)
	elif player_index == 2:
		instance.player_input = player
		instance.player_index = player_index	
		instance.position = Vector2(-900,0)
		instance.name = str(player_index)
		if grav_type_input.selected == 0:
			instance.gravity_scale = -1
		call_deferred("add_child",instance)
	elif player_index == 3:
		instance.player_input = player
		instance.player_index = player_index		
		instance.position = Vector2(900,0)
		instance.name = str(player_index)
		if grav_type_input.selected == 0:
			instance.gravity_scale = -1	
		call_deferred("add_child",instance)
	

func controler_connection_changed(device, connected):
	#if connected and GameVars.in_game:
	#	spawn_player(device)
	#if !connected and GameVars.in_game:
	#	print("killing player")
	#	Signals.call_deferred("emit_signal","player_disconnected",device)
	#if connected and !GameVars.in_game:
	#	spawn_cursor(device)
	#if !connected and !GameVars.in_game:
	#	Signals.call_deferred("emit_signal","cursor_disconnected",device)
	pass
	
func start_game():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	next_flip = GameVars.flip_interval
	Signals.emit_signal("start_game")
	GameVars.in_game = true
	$game_stuff.show()
	$Control.hide()
	for i in GameVars.connected_players:
		spawn_player(i)
	asteroid_timer.start(4)

func fade_scores():
	animations.play("fade")

func _on_start_button_pressed():
	start_game()
	animations.play("camera_to_game")

func spawn_message(text, time, color = Color(0,0,0)):
	message.text = text
	message.time = time
	message.color = color
	message.animations.play("fade_in")

func game_won(player):
	if player == "player1":
		spawn_message("Red Team Wins", 4)
	if player == "player2":
		spawn_message("Blue Team Wins", 4)
	reset_game()
	
func reset_game():
	player1score = 0
	player2score = 0
	$game_stuff.hide()
	$Control.show()
	Signals.emit_signal("reset_game")
	animations.play("camera_to_menu")
	for i in Input.get_connected_joypads():
		spawn_cursor(i)
	
func _on_music_finished():
	music.playing = true


func _on_asteroid_timer_timeout():
	print(GameVars.asteroid_count)
	print("making asteroid")
	var amount = randi_range(4,6)
	for i in amount:
		if GameVars.asteroid_count < 12:
			GameVars.asteroid_count += 1
			var instance = asteroid_scene.instantiate()
			asteroid_spawn.call_deferred("add_child",instance)

func player_joined():
	spawn_cursor(GameVars.connected_players[-1])
