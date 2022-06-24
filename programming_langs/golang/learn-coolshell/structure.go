package main

import "fmt"

// 如果想要一个方法可以被别的包访问的话，需要把首字母大写，这是一种约定。
// Person : structure
type Person struct {
	name  string
	age   int
	email string
}

func main2() {
	person := Person{"Tom", 30, "tom@gmail.com"}
	person = Person{name: "Tom", age: 30, email: "tom@gamil.com"}
	fmt.Println(person)

	person.name = "Jerry"
	fmt.Println(person.name, person)
}

// rect : structure method
type rect struct {
	width, height int
}

func (r *rect) area() int { // 求面积
	return r.width * r.height
}

func (r *rect) perimeter() int { // 求周长
	return 2 * (r.width + r.height)
}

func main() {
	r := rect{width: 10, height: 15}

	fmt.Println("面积:", r.area())
	fmt.Println("周长:", r.perimeter())

	rp := &r
	fmt.Println("面积:", rp.area())
	fmt.Println("周长:", rp.perimeter())

}
