class_name launch
extends Node2D

@export_group("Prefabs")
@export var hand_scene : PackedScene
@export var coin_scene : PackedScene

@export_group("Spawn settings")


var nombre_hands =1
# all vars
var left_border = 0
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var spawnRangeSize = 0.6
var spawnRange = screen_width * spawnRangeSize /2
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var hand_hauteur_position = 60
var handRandomSize =0.6

var canPlaceHand:bool = true
var currentHandNumber = 0
var play:bool = false

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
	print("ajkzkrzjl")
	if currentHandNumber >= nombre_hands: play= false
	
func launch() -> void:
	nombre_hands = PlayerVars.organes.get("arm")
	play = true



func _on_hand_spawn_delay_timeout() -> void:
	canPlaceHand = true

func placeHand() ->void:
	var hand_instance = hand_scene.instantiate()
	add_child(hand_instance)
	# position main
	var x_position = screen_width/2 + randf_range(-1,1)* spawnRange
	var y_position = screen_height - hand_hauteur_position
	var placement = Vector2(x_position,y_position)
	hand_instance.global_position = placement
	placeCoin(placement)
	# autres settings
	var handSize = hand_instance.scale.x + randf_range(-1,1)* handRandomSize
	hand_instance.scale = Vector2(handSize, handSize)

	
	
func placeCoin(position:Vector2) ->void:
	var coin_instance = coin_scene.instantiate()
	coin_instance.global_position = Vector2(screen_width/2,screen_height/2)
	add_child(coin_instance)
	
