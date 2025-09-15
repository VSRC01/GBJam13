@tool
extends MeshInstance3D

@export var size := 1024
@export var ground_scale := 4
@export var noise : NoiseTexture2D

@onready var img = noise.get_image()

func _ready() -> void:
	if noise:
		if img:
			mesh = generate_mesh()

func generate_mesh() -> ArrayMesh:
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	for x in range(size - 1):
		for z in range(size - 1):
			var h00 = round(img.get_pixel(x, z).r * 20.0)
			var h10 = round(img.get_pixel(x + 1, z).r * 20.0)
			var h01 = round(img.get_pixel(x, z + 1).r * 20.0)
			var h11 = round(img.get_pixel(x + 1, z + 1).r * 20.0)

			var p00 = Vector3(x, h00, z) * ground_scale
			var p10 = Vector3(x + 1, h10, z) * ground_scale
			var p01 = Vector3(x, h01, z + 1) * ground_scale
			var p11 = Vector3(x + 1, h11, z + 1) * ground_scale

			# Triangle 1
			st.add_vertex(p00)
			st.add_vertex(p10)
			st.add_vertex(p11)

			# Triangle 2
			st.add_vertex(p00)
			st.add_vertex(p11)
			st.add_vertex(p01)

	st.generate_normals() # important
	return st.commit()
