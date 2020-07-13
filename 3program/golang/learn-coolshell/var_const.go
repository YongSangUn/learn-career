package main

import "fmt"

// var: variable
var x int = 100
var str string = "Hello world!"
var i, j, k int = 1, 2, 3
var b = true

// a := 10086

//const: constant
const text string = "Go go go!"
const age int = 18
const pi float32 = 3.1415926535

func main() {
	a := 10086
	fmt.Println(x, i, j, k, str, b, a)
	fmt.Println(text, age, pi)
}
