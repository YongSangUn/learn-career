package main

import (
	"fmt"
)

func main() {
	//    pointer    //
	var i int = 1
	var pInt *int = &i
	fmt.Printf("i=%d\tpInt=%p\t*pInt=%d\n", i, pInt, *pInt)

	*pInt = 2
	fmt.Printf("i=%d\tpInt=%p\t*pInt=%d\n", i, pInt, *pInt)

	i = 3
	fmt.Printf("i=%d\tpInt=%p\t*pInt=%d\n", i, pInt, *pInt)

	//    memory allocation   //
	// new 只是清除内存，而非初始化内存，返回的是一个指向新分配类型为 T 的零值的指针。
	// make(T, args) 仅用于创建切片、map 和 chan (消息通道)，并返回类型 T (不是 *T) 的一个
	// 被初始化了的 (不是零) 的实例。
	// var p *[]int = new([]int)     //为切片结构分配内存; *p == nil; 很少使用
	// var v []int = make([]int, 10) // 切片 v 是对一个新的有10个整数的数组的引用

	// donot be complicated
	var p *[]int = new([]int)
	fmt.Println(p)
	*p = make([]int, 10, 10)
	fmt.Println(p)
	fmt.Println(*p)

	// usually used:
	v := make([]int, 10)
	fmt.Println(v, &v)
}
