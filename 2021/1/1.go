package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func ReadInput() []string {
	input, err := os.ReadFile("in.txt")
	if err != nil {
		log.Fatal("error reading input file")
	}
	in := string(input)
	return strings.Split(in, "\n")
}

func countMeasurements() {
	ins := ReadInput()
	cnt := 0
	for i := 1; i < len(ins); i++ {
		pm, _ := strconv.Atoi(ins[i-1])
		cm, _ := strconv.Atoi(ins[i])
		if pm < cm {
			cnt++
		}
	}
	fmt.Println(cnt)
}

func main() {
	countMeasurements()
}
