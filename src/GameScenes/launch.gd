class_name launch
extends Node2D

@export_group("Prefabs")
@export var hand_scene : PackedScene
@export var coin_scene : PackedScene

@export_group("Spawn settings")
@export var spawnRangeSize = 0.6
@export var hand_hauteur_position = 60
@export var handRandomSize =0.6
@export var placementOffset:Vector2
@export_subgroup("Timer")
@export var spawnStartDelay = 1.5
@export var coinCastDelay = 0.8
@export var handSpawnDelay = 0.6

# all vars
var nombre_hands =1
var left_border = 0
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var spawnRange = screen_width * spawnRangeSize /2
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")

var canPlaceHand:bool = true
var currentHandNumber = 0
var play:bool = false

var nom_piece = PlayerVars.pieces[PlayerVars.selectedPiece]
var dico_piece = PieceVars.pieces[nom_piece]


func _ready() -> void:
	RandomNumberGenerator.new().randomize()
	$handSpawnDelay.wait_time = handSpawnDelay
	$startDelay.wait_time = spawnStartDelay

# fonction appelé par le game manager
func launch() -> void:
	nombre_hands = PlayerVars.organes.get("arm") + PlayerVars.organes.get("tooth")
	PlayerVars.organes["tooth"]=0
	$startDelay.start()
	currentHandNumber = 0

# utilise le process car on travaille avec des timer 
func _process(delta: float) -> void:
	if !play: return
	# pour delay chaque hands
	if(!canPlaceHand): return
	currentHandNumber+=1
	# HANDS
	placeHand()
	# DELAY
	$handSpawnDelay.start()
	canPlaceHand = false
	if currentHandNumber >= nombre_hands: play= false


func placeHand() ->void:
	var hand_instance = hand_scene.instantiate()
	# position main
	var x_position = screen_width/2 + randf_range(-1,1)* spawnRange
	var y_position = screen_height - hand_hauteur_position
	var placement = Vector2(x_position,y_position)
	hand_instance.global_position = placement
	add_child(hand_instance)
	get_tree().create_timer(coinCastDelay).timeout.connect(placeCoin.bind(placement + placementOffset))
	
func placeCoin(position:Vector2) ->void:
	var coin_instance = coin_scene.instantiate()
	change_coin_type(coin_instance)
	position = Vector2(position.x-50,position.y-200)
	coin_instance.global_position = position
	add_child(coin_instance)

func _on_hand_spawn_delay_timeout() -> void:
	canPlaceHand = true

func _on_start_delay_timeout() -> void:
	play = true


func change_coin_type(coin:Coin) ->void:
	nom_piece = PlayerVars.pieces[PlayerVars.selectedPiece]
	dico_piece = PieceVars.pieces[nom_piece]
	coin.chance = dico_piece["luck"]
	coin.value = dico_piece["value"]
	coin.effect = dico_piece["effect"]
	coin.goodSideColor = dico_piece["color"]


func _on_table_topdown_round_finised() -> void:
	for child in get_children():
		if child is Coin || child is hand:
			child.queue_free()
