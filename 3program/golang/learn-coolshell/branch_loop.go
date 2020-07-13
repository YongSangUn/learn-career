package main

import (
	"fmt"
)

func main() {
	//    if    //
	x := 2
	// if
	if x%2 == 0 {
		fmt.Println(x, "is a even number.") // ...
	}

	// if-else
	x = 3
	if x%2 == 0 {
		fmt.Println(x, "is a even number.") // even number
	} else {
		fmt.Println(x, "is a odd number.") // odd number
	}

	// if-elseif-...-else
	num := -1
	if num < 0 {
		fmt.Println(num, "is a negative number.")
	} else if num == 0 {
		fmt.Println(num, "is a zero.")
	} else {
		fmt.Println(num, "is a positive number.")
	}

	//    switch    //
	// NOTE: switch statement without [ break ].
	i := 7
	// fmt.Printf("Write %d as ", i)
	switch i {
	case 1:
		fmt.Println("one")
	case 2:
		fmt.Println("two")
	case 3:
		fmt.Println("three")
	case 4, 5, 6:
		fmt.Println("four, five ,six")
	default:
		fmt.Println("invalid value!")
	}

	//    for    //
	// There is no [ while loop ] in Go program-language.
	// calssic for loop: init; condition; post
	for j := 0; j < 5; j++ {
		fmt.Println(j)
	}
	// simplify for loop: condition
	k := 0
	for k < 5 {
		fmt.Println(k)
		k++
	}
	//infinite loop, same like: for(;;)
	l := 1
	for {
		if i > 10 {
			break
		}
		fmt.Println(l)
		l++
	}
}
