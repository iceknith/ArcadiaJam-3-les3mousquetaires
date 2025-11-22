class_name Coin extends AnimatedSprite2D

signal onLanded(a,b)

@export_group("Stats")
@export var chance:float = 0.5
@export var value:float = 1
@export var price:int = 1
@export var effect = "aucun"

@export_group("Visuals")
@export var speed:float = 100
@export var weight:float = 10

var positionDepart: Vector2 
var positionFinale: Vector2 = Vector2.ZERO

var t: float = 0.0
var scale_initiale: Vector2

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var resultat = randf()
	if resultat > chance:
		add_to_group("coins")

	
	
