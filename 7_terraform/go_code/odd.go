package main

import (
	"fmt"
)

func Odd(n int) bool {
	return n%3 == 0
}

func main() {
	for i := 1; i <= 100; i++ {
		if Odd(i) {
			fmt.Println(i)
		}
	}
}
