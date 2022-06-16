extends Node2D


signal finished

func _ready() -> void:
  pass

func play():
  $animation.play('fadein')
  yield($animation, 'animation_finished')
  emit_signal('finished')
