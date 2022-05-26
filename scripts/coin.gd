extends Area2D

func _ready() -> void:
  pass # Replace with function body.


func _on_coin_body_entered(_body: Node) -> void:
  $action.play()
  $sprite.visible = false
  collision_mask = 0
  $queue_timer.start()
  $particles.emitting = true

func _on_queue_timer_timeout() -> void:
  queue_free()
