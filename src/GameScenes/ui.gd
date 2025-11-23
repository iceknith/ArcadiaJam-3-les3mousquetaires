extends Node

@export var bufferTimeBeforeAdding:float = 0.5
@export var totalCountDownTime:float = 1.2

var moneyBuffer:float
var displayedMoney:float

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("UI")
	displayedMoney = PlayerVars.money
	refresh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refresh():
	$money.text = str(displayedMoney) + " / " + str(PlayerVars.debt)
	if moneyBuffer > 0:
		$AddMoney.text = "+"
		$AddMoney.show()
	elif moneyBuffer < 0:
		$AddMoney.text = ""
		$AddMoney.show()
	else: 
		$AddMoney.hide()
	$AddMoney.text += str(moneyBuffer)
	
	if PlayerVars.round_left > 1:
		$round_left.text = str(PlayerVars.round_left) + " rounds left"
	elif PlayerVars.round_left == 1:
		$round_left.text = "Last round"
	else:
		$round_left.text = str(PlayerVars.round_left) + " rounds left"

func add_money(value:float):
	PlayerVars.money += value
	moneyBuffer += value
	$money/AddMoneyAnim.stop()

	$money/AddMoneyAnim.play("addBufferMoney")
	refresh()

func buy_things(value:float):
	PlayerVars.money -= value
	displayedMoney -= value
	$money/AddMoneyAnim.stop()
	$money/AddMoneyAnim.play("boughAnim")
	$CashRegisterMoney.play(0)
	refresh()

func set_money(value:float):
	PlayerVars.money = value
	displayedMoney = value
	$money/AddMoneyAnim.stop()
	$money/AddMoneyAnim.play("boughAnim")
	refresh()

func _on_round_ended() -> void:
	await get_tree().create_timer(bufferTimeBeforeAdding).timeout
	$money/MoneyTransvaseTimer.wait_time = totalCountDownTime/(roundf(moneyBuffer) + 1)
	$money/MoneyTransvaseTimer.start()

func _on_money_transvase_timer_timeout() -> void:
	if moneyBuffer != 0:
		var addedQuantity:float = min(sign(moneyBuffer), moneyBuffer)
		displayedMoney += addedQuantity
		moneyBuffer -= addedQuantity
		$money/AddMoneyAnim.stop()
		$money/AddMoneyAnim.play("transvase")
		$CashRegisterMoney.play(0)
		refresh()
	else: 
		$money/MoneyTransvaseTimer.stop()
