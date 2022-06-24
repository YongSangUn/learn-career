from name_function import get_formatted_name

while True:
    first = input("first name: ")
    if first == 'q':
        break
    last = input('last name: ')
    if last == 'q':
        break

    formatted_name = get_formatted_name(first, last)
    print(formatted_name)
