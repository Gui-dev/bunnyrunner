extends Area2D

func _ready() -> void:
  pass # Replace with function body.

func _on_coil_body_entered(body: Node) -> void:
  $sprite.play('action')
  $action.play()
  body._jump(1500, false)
