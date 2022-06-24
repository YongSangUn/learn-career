package main

import (
	"errors"
	"fmt"
)

// 自定义的出错结构
type myError struct {
	arg    int
	errMsg string
}

// 实现 Error 接口
func (e *myError) Error() string {
	return fmt.Sprintf("%d - %s", e.arg, e.errMsg)
}

// 两种出错
func errorTest(arg int) (int, error) {
	if arg < 0 {
		return -1, errors.New("Bad Arguments - negtive")
	} else if arg > 256 {
		return -1, &myError{arg, "Bad Arguments - too large"}
	}
	return arg * arg, nil
}

// test
func main() {
	for _, i := range []int{-1, 4, 1000} {
		if r, e := errorTest(i); e != nil {
			fmt.Println("failed: ", e)
		} else {
			fmt.Println("success: ", r)
		}
	}
}
