package admin

import (
	"GoOnlineJudge/class"
	"GoOnlineJudge/config"
	"html/template"
	"net/http"
	"strconv"
)

type news struct {
	Nid int `json:"nid"bson:"nid"`

	Title   string        `json:"title"bson:"title"`
	Content template.HTML `json:"content"bson:"content"`

	Status int    `json:"status"bson:"status"`
	Create string `json:"create"bson:'create'`
}

type NewsController struct {
	class.Controller
}

func (this *NewsController) Detail(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News Detail")
	this.Init(w, r)

	args := this.ParseURL(r.URL.String())
	nid, err := strconv.Atoi(args["nid"])
	if err != nil {
		http.Error(w, "args error", 400)
		return
	}

	response, err := http.Post(config.PostHost+"/news?detail/nid?"+strconv.Itoa(nid), "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	var one news
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
		this.Data["Detail"] = one
	} else {
		http.Error(w, "resp error", 500)
		return
	}

	this.Data["Title"] = "Admin - News Detail"
	this.Data["IsNews"] = true
	this.Data["IsList"] = false

	err = this.Execute(w, "view/admin/layout.tpl", "view/news_detail.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *NewsController) List(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News List")
	this.Init(w, r)

	response, err := http.Post(config.PostHost+"/news?list", "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	one := make(map[string][]news)
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 500)
			return
		}
		this.Data["News"] = one["list"]
	}

	this.Data["Title"] = "Admin - News List"
	this.Data["IsNews"] = true
	this.Data["IsList"] = true
	err = this.Execute(w, "view/admin/layout.tpl", "view/admin/news_list.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *NewsController) Add(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News Add")
	this.Init(w, r)

	this.Data["Title"] = "Admin - News Add"
	this.Data["IsNews"] = true
	this.Data["IsAdd"] = true
	this.Data["IsEdit"] = true

	err := this.Execute(w, "view/admin/layout.tpl", "view/admin/news_add.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *NewsController) Insert(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News Insert")
	this.Init(w, r)

	one := make(map[string]interface{})
	one["title"] = r.FormValue("title")
	one["content"] = r.FormValue("content")

	reader, err := this.PostReader(&one)
	if err != nil {
		http.Error(w, "read error", 500)
		return
	}

	response, err := http.Post(config.PostHost+"/news?insert", "application/json", reader)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	if response.StatusCode == 200 {
		http.Redirect(w, r, "/admin/news?list", http.StatusFound)
	}
}

func (this *NewsController) Status(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News Status")
	this.Init(w, r)

	args := this.ParseURL(r.URL.String())
	nid, err := strconv.Atoi(args["nid"])
	if err != nil {
		http.Error(w, "args error", 400)
		return
	}
	response, err := http.Post(config.PostHost+"/news?detail/nid?"+strconv.Itoa(nid), "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	var one news
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
	}
	var action int
	switch one.Status {
	case config.StatusAvailable:
		action = config.StatusReverse
	default:
		action = config.StatusAvailable
	}

	response, err = http.Post(config.PostHost+"/news?status/nid?"+strconv.Itoa(nid)+"/action?"+strconv.Itoa(action), "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	if response.StatusCode == 200 {
		http.Redirect(w, r, "/admin/news?list", http.StatusFound)
	}
}

func (this *NewsController) Delete(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News Delete")
	this.Init(w, r)

	args := this.ParseURL(r.URL.String())
	nid, err := strconv.Atoi(args["nid"])
	if err != nil {
		http.Error(w, "args error", 400)
		return
	}

	response, err := http.Post(config.PostHost+"/news?delete/nid?"+strconv.Itoa(nid), "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	w.WriteHeader(response.StatusCode)
}

func (this *NewsController) Edit(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News Edit")
	this.Init(w, r)

	args := this.ParseURL(r.URL.String())
	nid, err := strconv.Atoi(args["nid"])
	if err != nil {
		http.Error(w, "args error", 400)
		return
	}

	response, err := http.Post(config.PostHost+"/news?detail/nid?"+strconv.Itoa(nid), "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	var one news
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
		this.Data["Detail"] = one
	} else {
		http.Error(w, "resp error", response.StatusCode)
		return
	}

	this.Data["Title"] = "Admin - News Edit"
	this.Data["IsNews"] = true
	this.Data["IsList"] = false
	this.Data["IsEdit"] = true

	err = this.Execute(w, "view/admin/layout.tpl", "view/admin/news_edit.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *NewsController) Update(w http.ResponseWriter, r *http.Request) {
	class.Logger.Debug("Admin News Update")
	this.Init(w, r)

	args := this.ParseURL(r.URL.String())
	nid, err := strconv.Atoi(args["nid"])
	if err != nil {
		http.Error(w, "args error", 400)
		return
	}

	one := make(map[string]interface{})
	one["title"] = r.FormValue("title")
	one["content"] = r.FormValue("content")

	reader, err := this.PostReader(&one)
	if err != nil {
		http.Error(w, "read error", 500)
		return
	}

	response, err := http.Post(config.PostHost+"/news?update/nid?"+strconv.Itoa(nid), "application/json", reader)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	if response.StatusCode == 200 {
		http.Redirect(w, r, "/admin/news?detail/nid?"+strconv.Itoa(nid), http.StatusFound)
	} else {
		http.Error(w, "resp error", 500)
		return
	}
}
