extends Area2D

@onready var explosion = get_node("CPUParticles2D")
@export var player = PLAYERS.player1
@onready var audio = get_node("AudioStreamPlayer")

enum PLAYERS {player1, player2}



func _on_body_entered(body):
	print(body)
	if "ball" in body.name:
		audio.playing = true
		if player == PLAYERS.player1:
			Signals.emit_signal("player2_scored")
			explosion.emitting = true
		if player == PLAYERS.player2:
			Signals.emit_signal("player1_scored")
			explosion.rotation = 180
			explosion.emitting = true
			
