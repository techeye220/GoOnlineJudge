package contest

import (
	"GoOnlineJudge/class"
	"GoOnlineJudge/config"
	"net/http"
	"strconv"
)

type solution struct {
	Sid int `json:"sid"bson:"sid"`

	Pid      int    `json:"pid"bson:"pid"`
	Uid      string `json:"uid"bson:"uid"`
	Judge    int    `json:"judge"bson:"judge"`
	Time     int    `json:"time"bson:"time"`
	Memory   int    `json:"memory"bson:"memory"`
	Length   int    `json:"length"bson:"length"`
	Language int    `json:"language"bson:"language"`

	Module int `json:"module"bson:"module"`
	Mid    int `json:"mid"bson:"mid"`

	Code string `json:"code"bson:"code"`

	Status int   `json:"status"bson:"status"`
	Create int64 `json:"create"bson:"create"`
}

type StatusController struct {
	Contest
}

func (this *StatusController) List(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Contest Status List")
	this.InitContest(w, r)

	response, err := http.Post(config.PostHost+"/solution?list/module?"+strconv.Itoa(config.ModuleC)+"/mid?"+strconv.Itoa(this.Cid), "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	one := make(map[string][]solution)
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
		for i, v := range one["list"] {
			one["list"][i].Pid = this.Index[v.Pid]
		}
		this.Data["Solution"] = one["list"]
	}

	this.Data["Privilege"] = this.Privilege
	this.Data["IsContestStatus"] = true
	err = this.Execute(w, "view/layout.tpl", "view/contest/status_list.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *StatusController) Code(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Status Code")
	this.Init(w, r)
	this.InitContest(w, r)

	args := this.ParseURL(r.URL.String())
	sid, err := strconv.Atoi(args["sid"])
	if err != nil {
		http.Error(w, "args error", 400)
		return
	}

	response, err := http.Post(config.PostHost+"/solution?detail/sid?"+strconv.Itoa(sid), "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	var one solution
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
		this.Data["Solution"] = one
	}

	this.Data["Privilege"] = this.Privilege
	this.Data["Title"] = "View Code"
	this.Data["IsCode"] = true
	err = this.Execute(w, "view/layout.tpl", "view/contest/status_code.tpl")
	if err != nil {
		class.Logger.Debug(err)
		http.Error(w, "tpl error", 500)
		return
	}
}
