extends Node2D


onready var size = $bar.rect_size

func _ready() -> void:
  visible = false

func start(time: float) -> void:
  visible = true
  print('TIME: ', time)
