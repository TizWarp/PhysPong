extends Node

var color_index = {"Red":Color(255,0,0),"Blue":Color(0,0,255),"Green":Color(0,255,0),"Yellow":Color(255,255,0),"Black":Color(255,255,255),"White":Color(0,0,0),"Purple":Color(255,0,255),"Cyan":Color(0,255,255)}

var victory_score = 20
var gravity_type = GRAVITY_TYPES.two_and_two
enum GRAVITY_TYPES {two_and_two,all,no_flip_down,no_flip_up}
var boosts = true
var player1color = "Red"
var player2color = "Blue"
var player3color = "Green"
var player4color = "Yellow"
var in_game = false
var flip_interval
var soccer_mode = false
var player_ids = []
var asteroid_count = 0
var ball_pos = Vector2(0,0)

var connected_players = []
