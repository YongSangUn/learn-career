package main

import (
	"fmt"
)

func main() {
	m := make(map[string]int) //use [ make ] create a null map.
	m["one"] = 1
	m["two"] = 2
	m["three"] = 3
	fmt.Println("map:", m, "\nlen:", len(m))

	v := m["two"] // get the value in the map
	fmt.Println(v)

	delete(m, "two")
	fmt.Println(m)

	// create a complete map.
	m1 := map[string]int{"one": 1, "two": 2, "three": 3}
	fmt.Println(m1)

	// traverse the map.
	for key, val := range m1 {
		fmt.Printf("%s => %d \n", key, val)
	}
}
