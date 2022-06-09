extends Node2D


var coins = 0

func _ready() -> void:
  add_to_group('coin_counter')
  update_coin_label()
  
func pick_coin() -> void:
  coins += 1
  update_coin_label()

func update_coin_label() -> void:
  $coins.text = str(coins)
