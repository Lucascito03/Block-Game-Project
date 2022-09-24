extends RigidBody

var camera # the camera of the scene
var mesh # the mesh of this object
var original_color # the color that the mesh of this object has by default

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("/root/Spatial/Camera")
	mesh = get_node("Mesh")
	original_color = mesh.material.albedo_color

func _input(event):
	if event is InputEventMouseMotion:
		# Cast an imaginary 'ray' from the camera to where the mouse point
		# This is used to know which object the mouse selects
		var ray_length = 100;
		var from = camera.project_ray_origin(event.position);
		var to = from + camera.project_ray_normal(event.position) * ray_length;
		var space_state = get_world().direct_space_state;
		var result = space_state.intersect_ray(from, to)
		
		# Do a selection box around only if it's been hit by the ray
		mesh.material.albedo_color = original_color
		if result.size() != 0: # if the ray has collided.
			var collider = result.collider
			if collider == self:
				mesh.material.albedo_color = original_color.darkened(0.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
