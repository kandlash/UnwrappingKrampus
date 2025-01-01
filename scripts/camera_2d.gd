###Camera.gd###
extends Camera2D


# Shaking intensity (from 0.0 to 1.0)
var trauma = 0.0
# Exponent for power of shaking strength
var trauma_power = 2
# Put the shaking strength trauma as a power exponent trauma_power
var amount = 0.0

# Shaking intensity that decays in 1 second
# Note that if it is less than 0.0, the shaking will last forever
var decay = 0.8
# Maximum shaking width
# Hold each value in x-axis direction and y-axis direction as one data in Vector2 type
var max_offset = Vector2(36, 64) # display ratio is 16 : 9
# Maximum angle of rotation (in radians)
var max_roll = 0.1


# Built-in function called first when node is loaded
func _ready():
	# Randomize seed values for functions that return random values
	# Required since the same seed value will result in the same number of values obtained
	randomize()


# Built-in process function called every frame
func _process(delta):
	# If trauma is greater than 0
	if trauma:
		# Decay the intensity of the shaking
		trauma = max(trauma - decay * delta, 0)
		# Call a method to set the shaking width and rotation angle for rough shake
		# Call this method every frame to express screen shake
		rough_shake() # Define after this


# Method to set the shake width and rotation angle of rough shake
func rough_shake():
	# Amount is a cumulative value of the shaking intensity
	# pow() function raises the first argument to the power of the second argument as an exponent
	# The closer the intensity of the shaking to 0, the smaller the value becomes when powered
	# Example: 1.0 * 1.0 = 1.0, 0.5 * 0.5 = 0.25, 0.1 * 0.1 = 0.01
	amount = pow(trauma, trauma_power)
	# rotation angle = max_roll * amount * trauma power * random value from -1 to 1
	rotation = max_roll * amount * randf_range(-1, 1)
	# x-axis swing width = maximum swing width in x-axis direction * swing strength multiplied by power * random value between -1 and 1
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	# y-axis amplitude = max_offset.x * amount * rand_range(-1, 1) * random value between -1 and 1
	offset.y = max_offset.y * amount * randf_range(-1, 1)


# Methods to set trauma
func set_shake(add_trauma = 0.5):
	# Add the value of the argument add_trauma to the current trauma value
	# Set trauma to 1.0 if it is greater than or equal to 1.0
	trauma = min(trauma + add_trauma, 1.0)
