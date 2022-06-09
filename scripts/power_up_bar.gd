extends Node2D


onready var size = $bar.rect_size

func _ready() -> void:
  add_to_group('power_up_bar')
  visible = false

func start(time: float) -> void:
  visible = true
  $tween.interpolate_method(self, 'count', 1, 0, time, Tween.EASE_IN, 0)
  $tween.start()
  
func count(value: float) -> void:
  $bar.rect_size = Vector2(size.x * value, size.y)

func stop() -> void:
  $tween.stop_all()
  visible = false

func _on_tween_tween_completed(_object: Object, _key: NodePath) -> void:
  stop()
  get_tree().call_group('player', 'power_up_finished')
