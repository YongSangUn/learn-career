package main

import (
	"fmt"
	"math"
)

func main() {
	fmt.Println("Hello, world")
	fmt.Printf("%t\n", 1 == 2)
	fmt.Printf("二进制：%b\n", 255)
	fmt.Printf("八进制：%o\n", 255)
	fmt.Printf("十六进制：%X\n", 255)
	fmt.Printf("十进制%d\n", 255)
	fmt.Printf("浮点数：%f\n", math.Pi)
	fmt.Printf("字符串：%s\n", "hello world")
}
