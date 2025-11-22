class_name Coin extends AnimatedSprite2D

signal onLanded

@export_group("Stats")
@export var chance:float = 0.5
@export var value:float = 1
@export var price:int = 1

@export_group("Visuals")
@export var speed:float = 100
@export var weight:float = 10

var positionDepart: Vector2
var positionFinale: Vector2 = Vector2.ZERO
