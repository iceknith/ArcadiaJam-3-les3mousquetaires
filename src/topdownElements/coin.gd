class_name Coin extends Sprite2D

signal onLanded(a,b)

@export_group("Stats")
@export var chance:float = 0.5
@export var value:float = 1
@export var price:int = 1
@export var effect = "aucun"
@export var coinName:String

@export_group("Mouvements")
@export var mouvementMedian:Vector2 = Vector2(0,-500)
@export var variance:Vector2 = Vector2(100,100)

@export_group("Visuals")
@export var goodSideColor:Color
@export var badSideColor:Color

@export_group("AnimationVars")
@export var dist_to_posFinale_perc:float = 1
@export var color_perc:float = 0
@export var decided_color:bool = false
@export var modulateAlpha:float

var positionFinale:Vector2
var positionInit:Vector2

var resultat:bool

func _ready() -> void:
	resultat = randf() > chance
	positionInit = position
	positionFinale = positionInit + mouvementMedian + Vector2(randf()*variance.x, randf()*variance.y)
	var visibleRect = get_window().get_visible_rect()
	positionFinale = clamp(positionFinale, 
		visibleRect.position, 
		visibleRect.position + visibleRect.size)
	
	if resultat: 
		$Label.label_settings.font_color = goodSideColor
		$Label.text = "+ " + str(value)
	else: 
		$Label.label_settings.font_color = badSideColor
		$Label.text = "Oops"
	
	add_to_group("coins")
	
func _process(delta: float) -> void:
	position = positionInit + (positionFinale - positionInit) * dist_to_posFinale_perc
	if resultat && decided_color: 
		modulate = badSideColor + (goodSideColor - badSideColor) * color_perc
	else: 
		modulate = goodSideColor + (badSideColor - goodSideColor) * color_perc
	modulate.a = modulateAlpha
	$PointLight2D.color = modulate

func animEnded() -> void:
	pass
