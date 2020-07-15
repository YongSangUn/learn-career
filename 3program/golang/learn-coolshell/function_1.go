package main

import (
	"fmt"
)

//    example1    //
func main2() {
	fmt.Println(max(4, 5))
}

func max(a int, b int) int {
	if a > b {
		return a
	}
	return b
}

//    example2    //
func main() {
	v, e := multiRet("one")
	fmt.Println(v, e) // out: 1 true

	v, e = multiRet("four")
	fmt.Println(v, e) // out: 0 false

	// usually used:
	if v, e = multiRet("four"); e {
		// ture return
		fmt.Println(v)
	} else {
		// false return
		fmt.Println(v, "does not exist.")
	}
}

func multiRet(key string) (int, bool) {
	m := map[string]int{"one": 1, "two": 2, "three": 3}

	var err bool
	var val int

	val, err = m[key]

	return val, err
}
