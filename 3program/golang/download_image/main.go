package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"regexp"

	"github.com/xuri/excelize/v2"
)

// var waitGroup = new(sync.WaitGroup)
const logFile = ""
const imageSavePath = ""
const imageDataFile = ""

func main() {
	err := os.MkdirAll(imageSavePath, os.ModePerm)
	if err != nil {
		log.Println(err)
	}
	f, err2 := os.Create(logFile)
	if err2 != nil {
		log.Println(err)
	}
	defer f.Close()

	f.WriteString("==> 下载失败的图片如下:\n\n")
	f.Sync()

	arr := getColumnNameIndex(imageDataFile)
	if arr == [2]int{-1, -1} {
		fmt.Println("未发现驾驶证列表")
		pause()
		os.Exit(1)
	}
	carNoIndex, imageUrlIndex := arr[0], arr[1]

	rows := getImageData(imageDataFile)
	i := 0
	for rows.Next() {
		row, _ := rows.Columns()

		carNo, imageUrl := row[carNoIndex], row[imageUrlIndex]
		fileName := carNo + ".jpg"

		fmt.Printf("==> %.4d %s", i, fileName)
		err := saveImage(imageSavePath, fileName, imageUrl)
		if err != nil {
			f.WriteString(fmt.Sprintf("%d\t%s\t%s", i, carNo, imageUrl))
			f.Sync()
			fmt.Printf("\tFailed, %v\n", err)
			i += 1
			continue
		}
		fmt.Println("\tDone.")
		i += 1
	}

	// fmt.Println("Hello world!")
	pause()
}

func getImageData(imageDataFile string) (rows *excelize.Rows) {
	f, err := excelize.OpenFile(imageDataFile)
	if err != nil {
		fmt.Println(err)
		return nil
	}

	sheetName := f.GetSheetMap()[1]
	fmt.Println(sheetName)
	rows, err2 := f.Rows(sheetName)
	if err != nil {
		fmt.Println(err2)
		return nil
	}
	return rows

	// data := make(map[string]string)
	// fmt.Println(rows)
	// for rows.Next() {
	// 	row, _ := rows.Columns()
	// 	car_no, image_url := row[0], row[8]
	// 	data[car_no] = image_url
	// }
	// if err = rows.Close(); err != nil {
	// 	fmt.Println(err)
	// }
	// return data
}

func saveImage(imageSavePath string, fileName string, imageUrl string) error {
	filePath := imageSavePath + fileName
	res, err := http.Get(imageUrl)
	if err != nil {
		return err
	}
	// fmt.Printf("=> fileName: %s", fileName)
	data, err2 := ioutil.ReadAll(res.Body)
	if err2 != nil {
		// fmt.Printf("读取数据失败")
		return err2
	}
	err = ioutil.WriteFile(filePath, data, 0644)
	//计数器-1
	// waitGroup.Done()
	if err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func getColumnNameIndex(imageDataFile string) [2]int {
	rows := getImageData(imageDataFile)
	rows.Next()
	rows.Columns()
	rows.Next()
	rows.Columns()
	rows.Next()
	row, _ := rows.Columns()

	fmt.Println(row[0], row[8])
	reCarNo := regexp.MustCompile("^[\u4e00-\u9fa5][a-zA-Z][a-zA-Z0-9]{5,6}$")
	reImage := regexp.MustCompile("^http(s)?://.*$")
	var carNoMatch, imageUrlMatch bool
	var carNoIndex, imageUrlIndex int
	for i, column := range row {
		// fmt.Println(i, column)
		if reCarNo.MatchString(column) {
			// fmt.Println("recar")
			carNoIndex = i
			carNoMatch = true
		} else if reImage.MatchString(column) {
			// fmt.Println("reimg")
			imageUrlIndex = i
			imageUrlMatch = true
		}
	}
	// fmt.Println(carNoIndex, carNoMatch, imageUrlIndex, imageUrlMatch)
	if carNoMatch && imageUrlMatch {
		return [2]int{carNoIndex, imageUrlIndex}
	}
	return [2]int{-1, -1}
}

func pause() {
	fmt.Print("Press 'Enter' to continue...")
	bufio.NewReader(os.Stdin).ReadBytes('\n')
}
