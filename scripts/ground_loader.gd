extends MeshInstance3D

var MESH := preload("res://assets/world_quarter_mesh.tres")

func _ready() -> void:
	mesh = MESH
