extends Node2D


signal carrots_finished

func _ready() -> void:
  play(3)

func play(carrots) -> void:
  carrots = clamp(carrots, 0, 3)
  
  for set_carrot in range(carrots):
    var carrot = get_child(set_carrot)
    carrot.play()
    yield(carrot, 'finished')
    
  emit_signal('carrots_finished')
