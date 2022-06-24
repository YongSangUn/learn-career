package main

import (
	"fmt"
)

func main2() {
	sum(1, 2)
	sum(1, 2, 3)

	nums := []int{1, 2, 3, 4}
	sum(nums...)
}

// function's indefinite parameters. 函数的不定参数。
func sum(nums ...int) {
	fmt.Print(nums, " ")
	total := 0
	for _, num := range nums {
		total += num
	}
	fmt.Println(total)
}

// function closure
func main() {
	nextNumFunc := nextNum()
	for i := 0; i < 10; i++ {
		fmt.Print(nextNumFunc(), " ")
	}
}
func nextNum() func() int {
	i, j := 1, 1
	return func() int {
		var tmp = i + j
		i, j = j, tmp
		return tmp
	}
}
