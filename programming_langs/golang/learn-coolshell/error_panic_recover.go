package main
var user = os.Getenv("USER")
func init(){
	if user ==""{
		panic("no value for $USER")
	}
}