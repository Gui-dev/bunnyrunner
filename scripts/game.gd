extends Node2D


func _ready() -> void:
  add_to_group('game')

func stage_selected(button: Button) -> void:
  print(typeof(button))
  print(button.stage)
