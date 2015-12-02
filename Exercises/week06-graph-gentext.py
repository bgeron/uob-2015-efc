data = [
	('A', 'S'),
	('A', 'T'),
	('A', 'Z'),
	('B', 'G'),
	('B', 'P'),
	('B', 'U'),
	('C', 'R'),
	('D', 'C'),
	('F', 'B'),
	('H', 'E'),
	('I', 'N'),
	('L', 'M'),
	('M', 'D'),
	('O', 'Z'),
	('P', 'C'),
	('R', 'P'),
	('R', 'S'),
	('S', 'F'),
	('S', 'O'),
	('T', 'L'),
	('U', 'H'),
	('U', 'V'),
	('V', 'I'),
]

d = dict()

for (x, y) in data:
	d.setdefault(x, [])
	d.setdefault(y, [])
	d[x].append(y)
	d[y].append(x)

for x in sorted(d):
	print('{}: {}'.format(x, ','.join(d[x])))
