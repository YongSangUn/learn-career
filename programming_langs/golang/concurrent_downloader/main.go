package main

import (
	"bufio"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"path"
	"runtime"
	"sync"

	"github.com/schollz/progressbar/v3"
)

// var waitGroup = new(sync.WaitGroup)
const logFile = ""
const imageSavePath = ""
const imageDataFile = ""

type Resource struct {
	Filename string
	Url      string
}

type Downloader struct {
	wg         *sync.WaitGroup
	pool       chan *Resource
	Concurrent int
	TargetDir  string
	Resources  []Resource
}

func main() {
	downloader := NewDownloader("./")
	url := "https://img.paulzzh.tech/touhou/random?2"
	for i := 1; i < 8; i++ {
		name := fmt.Sprintf("%d.jpg", i)
		downloader.AppendResource(name, url)
	}
	// downloader.Concurrent = 4
	err := downloader.Start()
	if err != nil {
		panic(err)
	}

	defer pause()
}

func NewDownloader(targetDir string) *Downloader {
	concurrent := runtime.NumCPU()
	return &Downloader{
		wg:         &sync.WaitGroup{},
		TargetDir:  targetDir,
		Concurrent: concurrent,
	}
}

func (d *Downloader) AppendResource(filename, url string) {
	d.Resources = append(d.Resources, Resource{
		Filename: filename,
		Url:      url,
	})
}

//func (d *Downloader) Download(resource Resource, progress *mpb.Progress) error {
func (d *Downloader) DownloadNoBar(resource Resource) error {
	defer d.wg.Done()
	d.pool <- &resource
	finalPath := path.Join(d.TargetDir, resource.Filename)

	req, err := http.Get(resource.Url)
	if err != nil {
		return err
	}

	data, err2 := ioutil.ReadAll(req.Body)
	if err2 != nil {
		return err2
	}
	err = ioutil.WriteFile(finalPath, data, 0644)

	if err != nil {
		fmt.Println(err)
		return err
	}

	<-d.pool
	return nil
}
func (d *Downloader) Download(resource Resource) error {
	defer d.wg.Done()
	d.pool <- &resource
	finalPath := path.Join(d.TargetDir, resource.Filename)

	req, err := http.NewRequest("GET", resource.Url, nil)
	if err != nil {
		return err
	}
	resp, _ := http.DefaultClient.Do(req)

	f, _ := os.OpenFile(finalPath, os.O_CREATE|os.O_WRONLY, 0644)
	defer f.Close()

	bar := progressbar.DefaultBytes(
		resp.ContentLength,
		resource.Filename,
	)
	io.Copy(io.MultiWriter(f, bar), resp.Body)

	if err != nil {
		fmt.Println(err)
		return err
	}

	<-d.pool
	return nil
}

func (d *Downloader) Start() error {
	d.pool = make(chan *Resource, d.Concurrent)
	fmt.Println("开始下载，当前并发：", d.Concurrent)
	// p := mpb.New(mpb.WithWaitGroup(d.wg))
	for _, resource := range d.Resources {
		d.wg.Add(1)
		// go d.Download(resource, p)
		go d.Download(resource)
	}
	// p.Wait()
	d.wg.Wait()
	return nil
}

func pause() {
	fmt.Print("Press 'Enter' to continue...")
	bufio.NewReader(os.Stdin).ReadBytes('\n')
}
