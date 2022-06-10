extends Area2D


func _ready() -> void:
  pass


func _on_carrot_body_entered(body: Node) -> void:
 body.victory()


func _on_deadzone_body_entered(body: Node) -> void:
 body.killed()
