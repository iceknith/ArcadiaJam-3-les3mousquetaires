class_name launch
extends Node2D

@export var hand_scene : PackedScene
@export var coin_scene : PackedScene

# all vars
var nombre_hands = PlayerVars.organes.get("arm")
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func launch() -> void:
	for h in nombre_hands:
		var hand_instance = hand_scene.instantiate()
		add_child(hand_instance)
		var coin_instance = coin_scene.instantiate()
		add_child(hand_instance)
