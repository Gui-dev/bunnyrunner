extends Node2D


func _ready() -> void:
  pass


func _on_head_body_entered(body: Node) -> void:
  $body.collision_mask = 0
  body._jump(800, false)
  $hurt.play()
  $animation.play('destroy')
  yield($animation, 'animation_finished')
  queue_free()


func _on_body_body_entered(body: Node) -> void:
  print('BODY: ', body)
