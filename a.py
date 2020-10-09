import itertools

x = itertools.count(start=20, step=-1)
print(list(itertools.islice(x, 0, 10, 2)))
