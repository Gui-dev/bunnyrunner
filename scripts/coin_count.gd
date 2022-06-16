extends Node2D


var coins = 0 setget set_coins

func _ready() -> void:
  add_to_group('coin_counter')
  update_coin_label()
  
func pick_coin() -> void:
  self.coins += 1

func update_coin_label() -> void:
  $coins.text = str(coins)

func set_coins(coin: int) -> void:
  coins = coin
  update_coin_label()
