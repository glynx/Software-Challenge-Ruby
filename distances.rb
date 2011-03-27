# This a two-dimensional array provided by Dennis Glindemann. USAGE: distance = $distances[from][to]
$distances = [[0,6,6,6,6,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,7,8,9,10,11,10,9,8,7,7,8,9,10,11,10,9,8,7,7,8,9,10,11,10,9,8,7,7,8,9,10,11,10,9,8,7,7,7,7,7],
			[6,0,12,10,10,5,4,3,2,1,7,8,9,10,11,7,8,9,10,11,7,8,9,10,11,11,12,13,14,15,16,15,14,13,13,14,15,16,15,14,13,12,11,9,8,7,6,5,4,3,2,1,1,2,3,4,5,6,7,8,9,11,13,11,1],
			[6,12,0,10,10,7,8,9,10,11,5,4,3,2,1,7,8,9,10,11,7,8,9,10,11,9,8,7,6,5,4,3,2,1,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,15,14,13,13,14,15,16,15,14,13,12,11,11,1,11,13],
			[6,10,10,0,12,7,8,9,10,11,7,8,9,10,11,5,4,3,2,1,7,8,9,10,11,13,14,15,16,15,14,13,12,11,9,8,7,6,5,4,3,2,1,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,15,14,13,13,11,1,11],
			[6,10,10,12,0,7,8,9,10,11,7,8,9,10,11,7,8,9,10,11,5,4,3,2,1,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,15,14,13,13,14,15,16,15,14,13,12,11,9,8,7,6,5,4,3,2,1,1,11,13,11],
			[1,5,7,7,7,0,1,2,3,4,2,3,4,5,6,2,3,4,5,6,2,3,4,5,6,8,9,10,11,12,11,10,9,8,8,9,10,11,12,11,10,9,8,8,9,10,11,10,9,8,7,6,6,7,8,9,10,11,10,9,8,8,8,8,6],
			[2,4,8,8,8,1,0,1,2,3,3,4,5,6,7,3,4,5,6,7,3,4,5,6,7,9,10,11,12,13,12,11,10,9,9,10,11,12,13,12,11,10,9,9,10,11,10,9,8,7,6,5,5,6,7,8,9,10,11,10,9,9,9,9,5],
			[3,3,9,9,9,2,1,0,1,2,4,5,6,7,8,4,5,6,7,8,4,5,6,7,8,10,11,12,13,14,13,12,11,10,10,11,12,13,14,13,12,11,10,10,11,10,9,8,7,6,5,4,4,5,6,7,8,9,10,11,10,10,10,10,4],
			[4,2,10,10,10,3,2,1,0,1,5,6,7,8,9,5,6,7,8,9,5,6,7,8,9,11,12,13,14,15,14,13,12,11,11,12,13,14,15,14,13,12,11,11,10,9,8,7,6,5,4,3,3,4,5,6,7,8,9,10,11,11,11,11,3],
			[5,1,11,11,11,4,3,2,1,0,6,7,8,9,10,6,7,8,9,10,6,7,8,9,10,12,13,14,15,16,15,14,13,12,12,13,14,15,16,15,14,13,12,10,9,8,7,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,12,12,2],
			[1,7,5,7,7,2,3,4,5,6,0,1,2,3,4,2,3,4,5,6,2,3,4,5,6,8,9,10,11,10,9,8,7,6,6,7,8,9,10,11,10,9,8,8,9,10,11,12,11,10,9,8,8,9,10,11,12,11,10,9,8,8,6,8,8],
			[2,8,4,8,8,3,4,5,6,7,1,0,1,2,3,3,4,5,6,7,3,4,5,6,7,9,10,11,10,9,8,7,6,5,5,6,7,8,9,10,11,10,9,9,10,11,12,13,12,11,10,9,9,10,11,12,13,12,11,10,9,9,5,9,9],
			[3,9,3,9,9,4,5,6,7,8,2,1,0,1,2,4,5,6,7,8,4,5,6,7,8,10,11,10,9,8,7,6,5,4,4,5,6,7,8,9,10,11,10,10,11,12,13,14,13,12,11,10,10,11,12,13,14,13,12,11,10,10,4,10,10],
			[4,10,2,10,10,5,6,7,8,9,3,2,1,0,1,5,6,7,8,9,5,6,7,8,9,11,10,9,8,7,6,5,4,3,3,4,5,6,7,8,9,10,11,11,12,13,14,15,14,13,12,11,11,12,13,14,15,14,13,12,11,11,3,11,11],
			[5,11,1,11,11,6,7,8,9,10,4,3,2,1,0,6,7,8,9,10,6,7,8,9,10,10,9,8,7,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,13,14,15,16,15,14,13,12,12,13,14,15,16,15,14,13,12,12,2,12,12],
			[1,7,7,5,7,2,3,4,5,6,2,3,4,5,6,0,1,2,3,4,2,3,4,5,6,8,9,10,11,12,11,10,9,8,8,9,10,11,10,9,8,7,6,6,7,8,9,10,11,10,9,8,8,9,10,11,12,11,10,9,8,8,8,6,8],
			[2,8,8,4,8,3,4,5,6,7,3,4,5,6,7,1,0,1,2,3,3,4,5,6,7,9,10,11,12,13,12,11,10,9,9,10,11,10,9,8,7,6,5,5,6,7,8,9,10,11,10,9,9,10,11,12,13,12,11,10,9,9,9,5,9],
			[3,9,9,3,9,4,5,6,7,8,4,5,6,7,8,2,1,0,1,2,4,5,6,7,8,10,11,12,13,14,13,12,11,10,10,11,10,9,8,7,6,5,4,4,5,6,7,8,9,10,11,10,10,11,12,13,14,13,12,11,10,10,10,4,10],
			[4,10,10,2,10,5,6,7,8,9,5,6,7,8,9,3,2,1,0,1,5,6,7,8,9,11,12,13,14,15,14,13,12,11,11,10,9,8,7,6,5,4,3,3,4,5,6,7,8,9,10,11,11,12,13,14,15,14,13,12,11,11,11,3,11],
			[5,11,11,1,11,6,7,8,9,10,6,7,8,9,10,4,3,2,1,0,6,7,8,9,10,12,13,14,15,16,15,14,13,12,10,9,8,7,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,13,14,15,16,15,14,13,12,12,12,2,12],
			[1,7,7,7,5,2,3,4,5,6,2,3,4,5,6,2,3,4,5,6,0,1,2,3,4,6,7,8,9,10,11,10,9,8,8,9,10,11,12,11,10,9,8,8,9,10,11,12,11,10,9,8,8,9,10,11,10,9,8,7,6,6,8,8,8],
			[2,8,8,8,4,3,4,5,6,7,3,4,5,6,7,3,4,5,6,7,1,0,1,2,3,5,6,7,8,9,10,11,10,9,9,10,11,12,13,12,11,10,9,9,10,11,12,13,12,11,10,9,9,10,11,10,9,8,7,6,5,5,9,9,9],
			[3,9,9,9,3,4,5,6,7,8,4,5,6,7,8,4,5,6,7,8,2,1,0,1,2,4,5,6,7,8,9,10,11,10,10,11,12,13,14,13,12,11,10,10,11,12,13,14,13,12,11,10,10,11,10,9,8,7,6,5,4,4,10,10,10],
			[4,10,10,10,2,5,6,7,8,9,5,6,7,8,9,5,6,7,8,9,3,2,1,0,1,3,4,5,6,7,8,9,10,11,11,12,13,14,15,14,13,12,11,11,12,13,14,15,14,13,12,11,11,10,9,8,7,6,5,4,3,3,11,11,11],
			[5,11,11,11,1,6,7,8,9,10,6,7,8,9,10,6,7,8,9,10,4,3,2,1,0,2,3,4,5,6,7,8,9,10,12,13,14,15,16,15,14,13,12,12,13,14,15,16,15,14,13,12,10,9,8,7,6,5,4,3,2,2,12,12,12],
			[7,11,9,13,1,8,9,10,11,12,8,9,10,11,10,8,9,10,11,12,6,5,4,3,2,0,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,15,14,14,15,16,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,2,10,14,12],
			[8,12,8,14,2,9,10,11,12,13,9,10,11,10,9,9,10,11,12,13,7,6,5,4,3,1,0,1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,15,15,16,17,18,17,16,15,14,13,11,10,9,8,7,6,5,4,3,3,9,15,13],
			[9,13,7,15,3,10,11,12,13,14,10,11,10,9,8,10,11,12,13,14,8,7,6,5,4,2,1,0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,16,17,18,19,18,17,16,15,14,12,11,10,9,8,7,6,5,4,4,8,16,14],
			[10,14,6,16,4,11,12,13,14,15,11,10,9,8,7,11,12,13,14,15,9,8,7,6,5,3,2,1,0,1,2,3,4,5,7,8,9,10,11,12,13,14,15,17,18,19,20,19,18,17,16,15,13,12,11,10,9,8,7,6,5,5,7,17,15],
			[11,15,5,15,5,12,13,14,15,16,10,9,8,7,6,12,13,14,15,16,10,9,8,7,6,4,3,2,1,0,1,2,3,4,6,7,8,9,10,11,12,13,14,16,17,18,19,20,19,18,17,16,14,13,12,11,10,9,8,7,6,6,6,16,16],
			[10,16,4,14,6,11,12,13,14,15,9,8,7,6,5,11,12,13,14,15,11,10,9,8,7,5,4,3,2,1,0,1,2,3,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,19,18,17,15,14,13,12,11,10,9,8,7,7,5,15,17],
			[9,15,3,13,7,10,11,12,13,14,8,7,6,5,4,10,11,12,13,14,10,11,10,9,8,6,5,4,3,2,1,0,1,2,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,18,17,16,16,15,14,13,12,11,10,9,8,8,4,14,16],
			[8,14,2,12,8,9,10,11,12,13,7,6,5,4,3,9,10,11,12,13,9,10,11,10,9,7,6,5,4,3,2,1,0,1,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,17,16,15,15,16,15,14,13,12,11,10,9,9,3,13,15],
			[7,13,1,11,9,8,9,10,11,12,6,5,4,3,2,8,9,10,11,12,8,9,10,11,10,8,7,6,5,4,3,2,1,0,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,16,15,14,14,15,16,15,14,13,12,11,10,10,2,12,14],
			[7,13,1,9,11,8,9,10,11,12,6,5,4,3,2,8,9,10,11,10,8,9,10,11,12,10,9,8,7,6,5,4,3,2,0,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,15,14,14,15,16,17,16,15,14,13,12,12,2,10,14],
			[8,14,2,8,12,9,10,11,12,13,7,6,5,4,3,9,10,11,10,9,9,10,11,12,13,11,10,9,8,7,6,5,4,3,1,0,1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,15,15,16,17,18,17,16,15,14,13,13,3,9,15],
			[9,15,3,7,13,10,11,12,13,14,8,7,6,5,4,10,11,10,9,8,10,11,12,13,14,12,11,10,9,8,7,6,5,4,2,1,0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,16,17,18,19,18,17,16,15,14,14,4,8,16],
			[10,16,4,6,14,11,12,13,14,15,9,8,7,6,5,11,10,9,8,7,11,12,13,14,15,13,12,11,10,9,8,7,6,5,3,2,1,0,1,2,3,4,5,7,8,9,10,11,12,13,14,15,17,18,19,20,19,18,17,16,15,15,5,7,17],
			[11,15,5,5,15,12,13,14,15,16,10,9,8,7,6,10,9,8,7,6,12,13,14,15,16,14,13,12,11,10,9,8,7,6,4,3,2,1,0,1,2,3,4,6,7,8,9,10,11,12,13,14,16,17,18,19,20,19,18,17,16,16,6,6,16],
			[10,14,6,4,16,11,12,13,14,15,11,10,9,8,7,9,8,7,6,5,11,12,13,14,15,15,14,13,12,11,10,9,8,7,5,4,3,2,1,0,1,2,3,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,19,18,17,17,7,5,15],
			[9,13,7,3,15,10,11,12,13,14,10,11,10,9,8,8,7,6,5,4,10,11,12,13,14,16,15,14,13,12,11,10,9,8,6,5,4,3,2,1,0,1,2,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,18,17,16,16,8,4,14],
			[8,12,8,2,14,9,10,11,12,13,9,10,11,10,9,7,6,5,4,3,9,10,11,12,13,15,16,15,14,13,12,11,10,9,7,6,5,4,3,2,1,0,1,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,17,16,15,15,9,3,13],
			[7,11,9,1,13,8,9,10,11,12,8,9,10,11,10,6,5,4,3,2,8,9,10,11,12,14,15,16,15,14,13,12,11,10,8,7,6,5,4,3,2,1,0,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,16,15,14,14,10,2,12],
			[7,9,11,1,13,8,9,10,11,10,8,9,10,11,12,6,5,4,3,2,8,9,10,11,12,14,15,16,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,0,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,15,14,14,12,2,10],
			[8,8,12,2,14,9,10,11,10,9,9,10,11,12,13,7,6,5,4,3,9,10,11,12,13,15,16,17,18,17,16,15,14,13,11,10,9,8,7,6,5,4,3,1,0,1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,15,15,13,3,9],
			[9,7,13,3,15,10,11,10,9,8,10,11,12,13,14,8,7,6,5,4,10,11,12,13,14,16,17,18,19,18,17,16,15,14,12,11,10,9,8,7,6,5,4,2,1,0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,16,14,4,8],
			[10,6,14,4,16,11,10,9,8,7,11,12,13,14,15,9,8,7,6,5,11,12,13,14,15,17,18,19,20,19,18,17,16,15,13,12,11,10,9,8,7,6,5,3,2,1,0,1,2,3,4,5,7,8,9,10,11,12,13,14,15,17,15,5,7],
			[11,5,15,5,15,10,9,8,7,6,12,13,14,15,16,10,9,8,7,6,12,13,14,15,16,16,17,18,19,20,19,18,17,16,14,13,12,11,10,9,8,7,6,4,3,2,1,0,1,2,3,4,6,7,8,9,10,11,12,13,14,16,16,6,6],
			[10,4,16,6,14,9,8,7,6,5,11,12,13,14,15,11,10,9,8,7,11,12,13,14,15,15,16,17,18,19,20,19,18,17,15,14,13,12,11,10,9,8,7,5,4,3,2,1,0,1,2,3,5,6,7,8,9,10,11,12,13,15,17,7,5],
			[9,3,15,7,13,8,7,6,5,4,10,11,12,13,14,10,11,10,9,8,10,11,12,13,14,14,15,16,17,18,19,18,17,16,16,15,14,13,12,11,10,9,8,6,5,4,3,2,1,0,1,2,4,5,6,7,8,9,10,11,12,14,16,8,4],
			[8,2,14,8,12,7,6,5,4,3,9,10,11,12,13,9,10,11,10,9,9,10,11,12,13,13,14,15,16,17,18,17,16,15,15,16,15,14,13,12,11,10,9,7,6,5,4,3,2,1,0,1,3,4,5,6,7,8,9,10,11,13,15,9,3],
			[7,1,13,9,11,6,5,4,3,2,8,9,10,11,12,8,9,10,11,10,8,9,10,11,12,12,13,14,15,16,17,16,15,14,14,15,16,15,14,13,12,11,10,8,7,6,5,4,3,2,1,0,2,3,4,5,6,7,8,9,10,12,14,10,2],
			[7,1,13,11,9,6,5,4,3,2,8,9,10,11,12,8,9,10,11,12,8,9,10,11,10,10,11,12,13,14,15,16,15,14,14,15,16,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,0,1,2,3,4,5,6,7,8,10,14,12,2],
			[8,2,14,12,8,7,6,5,4,3,9,10,11,12,13,9,10,11,12,13,9,10,11,10,9,9,10,11,12,13,14,15,16,15,15,16,17,18,17,16,15,14,13,11,10,9,8,7,6,5,4,3,1,0,1,2,3,4,5,6,7,9,15,13,3],
			[9,3,15,13,7,8,7,6,5,4,10,11,12,13,14,10,11,12,13,14,10,11,10,9,8,8,9,10,11,12,13,14,15,16,16,17,18,19,18,17,16,15,14,12,11,10,9,8,7,6,5,4,2,1,0,1,2,3,4,5,6,8,16,14,4],
			[10,4,16,14,6,9,8,7,6,5,11,12,13,14,15,11,12,13,14,15,11,10,9,8,7,7,8,9,10,11,12,13,14,15,17,18,19,20,19,18,17,16,15,13,12,11,10,9,8,7,6,5,3,2,1,0,1,2,3,4,5,7,17,15,5],
			[11,5,15,15,5,10,9,8,7,6,12,13,14,15,16,12,13,14,15,16,10,9,8,7,6,6,7,8,9,10,11,12,13,14,16,17,18,19,20,19,18,17,16,14,13,12,11,10,9,8,7,6,4,3,2,1,0,1,2,3,4,6,16,16,6],
			[10,6,14,16,4,11,10,9,8,7,11,12,13,14,15,11,12,13,14,15,9,8,7,6,5,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,19,18,17,15,14,13,12,11,10,9,8,7,5,4,3,2,1,0,1,2,3,5,15,17,7],
			[9,7,13,15,3,10,11,10,9,8,10,11,12,13,14,10,11,12,13,14,8,7,6,5,4,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,18,17,16,16,15,14,13,12,11,10,9,8,6,5,4,3,2,1,0,1,2,4,14,16,8],
			[8,8,12,14,2,9,10,11,10,9,9,10,11,12,13,9,10,11,12,13,7,6,5,4,3,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,17,16,15,15,16,15,14,13,12,11,10,9,7,6,5,4,3,2,1,0,1,3,13,15,9],
			[7,9,11,13,1,8,9,10,11,10,8,9,10,11,12,8,9,10,11,12,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,16,15,14,14,15,16,15,14,13,12,11,10,8,7,6,5,4,3,2,1,0,2,12,14,10],
			[7,11,11,13,1,8,9,10,11,12,8,9,10,11,12,8,9,10,11,12,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,16,15,14,14,15,16,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,0,12,14,12],
			[7,13,1,11,11,8,9,10,11,12,6,5,4,3,2,8,9,10,11,12,8,9,10,11,12,10,9,8,7,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,16,15,14,14,15,16,17,16,15,14,13,12,12,0,12,14],
			[7,11,11,1,13,8,9,10,11,12,8,9,10,11,12,6,5,4,3,2,8,9,10,11,12,14,15,16,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,16,15,14,14,12,0,12],
				 [7,1,13,11,11,6,5,4,3,2,8,9,10,11,12,8,9,10,11,12,8,9,10,11,12,12,13,14,15,16,17,16,15,14,14,15,16,17,16,15,14,13,12,10,9,8,7,6,5,4,3,2,2,3,4,5,6,7,8,9,10,12,14,12,0]
]