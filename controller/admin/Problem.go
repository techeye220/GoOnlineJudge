package admin

import (
	"GoOnlineJudge/class"
	"GoOnlineJudge/config"
	"html/template"
	"log"
	"net/http"
)

type problem struct {
	Pid int `json:"pid"bson:"pid"`

	Time    int    `json:"time"bson:"time"`
	Memory  int    `json:"memory"bson:"memory"`
	Special int    `json:"special"bson:"special"`
	Expire  string `json:"expire"bson:"expire"`

	Title       string        `json:"title"bson:"title"`
	Description template.HTML `json:"description"bson:"description"`
	Input       template.HTML `json:"input"bson:"input"`
	Output      template.HTML `json:"output"bson:"output"`
	Source      string        `json:"source"bson:"source"`
	Hint        string        `json:"hint"bson:"hint"`

	In  string `json:"in"bson:"in"`
	Out string `json:"out"bson:"out"`

	Solve  int `json:"solve"bson:"solve"`
	Submit int `json:"submit"bson:"submit"`

	Status int    `json:"status"bson:"status"`
	Create string `json:"create"bson:"create"`
}

type ProblemController struct {
	class.Controller
}

func (this *ProblemController) List(w http.ResponseWriter, r *http.Request) {
	log.Println("Admin Problem List")
	this.Init(w, r)

	response, err := http.Post(config.PostHost+"/problem/list", "application/json", nil)
	defer response.Body.Close()
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}

	one := make(map[string][]*problem)
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
		this.Data["Problem"] = one["list"]
	}

	t := template.New("layout.tpl").Funcs(template.FuncMap{"ShowStatus": class.ShowStatus})
	t, err = t.ParseFiles("view/admin/layout.tpl", "view/admin/problem_list.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}

	this.Data["Title"] = "Admin - Problem List"
	this.Data["IsProblem"] = true
	this.Data["IsList"] = true
	err = t.Execute(w, this.Data)
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *ProblemController) Add(w http.ResponseWriter, r *http.Request) {
	log.Println("Admin Problem Add")
	this.Init(w, r)

	t := template.New("layout.tpl")
	t, err := t.ParseFiles("view/admin/layout.tpl", "view/admin/problem_add.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}

	this.Data["Title"] = "Admin - Problem Add"
	this.Data["IsProblem"] = true
	this.Data["IsAdd"] = true
	err = t.Execute(w, this.Data)
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *ProblemController) Insert(w http.ResponseWriter, r *http.Request) {
	log.Println("Admin Problem Insert")
	this.Init(w, r)

	//TODO r.body to json
	response, err := http.Post(config.PostHost+"/problem/insert", "application/json", r.Body)
	defer response.Body.Close()
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}

	ret := make(map[string]interface{})
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &ret)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
		log.Println(ret["pid"])
	}
}
