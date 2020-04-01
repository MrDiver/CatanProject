extends Spatial
class_name HexMap

var numbers = [2,3,3,4,4,5,5,6,6,8,8,9,9,10,10,11,11,12]
var fields = ["Wald","Wald","Wald","Wald",
				"Schafe","Schafe","Schafe","Schafe",
				"Getreide","Getreide","Getreide","Getreide",
				"Lehm","Lehm","Lehm",
				"Stein","Stein","Stein",
				"Wueste"]

func _ready():
	seed(Globals.SEED)
	var childs = self.get_children()
	for c in childs:
		#Setting tile types random
		var i = randi()%fields.size()
		var tmptype = fields[i]
		fields.remove(i)
		c.setType(tmptype)	
		# Setting a random number for every tile
		if c.isWueste():
			continue

		i = randi()%numbers.size()
		var tmpnum = numbers[i]
		numbers.remove(i)
		c.setNumber(tmpnum)
		#print("Set: ",tmpnum," Numbers:",numbers)
