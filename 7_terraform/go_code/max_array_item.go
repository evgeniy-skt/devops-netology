package main

import (
	"fmt"
)

func main() {
	x := []int{0, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17, 101}
	var result int
	for j := 1; j < len(x); j++ {
		if x[0] < x[j] {
			result = x[j]
		}
	}
	fmt.Println(result)
}
