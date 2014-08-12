package admin

import (
	"GoOnlineJudge/class"
	"GoOnlineJudge/config"
	"encoding/json"
	"html/template"
	"log"
	"net/http"
)

type user struct {
	Uid string `json:"uid"bson:"uid"`
	Pwd string `json:"pwd"bson:"pwd"`

	Nick   string `json:"nick"bson:"nick"`
	Mail   string `json:"mail"bson:"mail"`
	School string `json:"school"bson:"school"`
	Motto  string `json:"motto"bson:"motto"`

	Privilege int `json:"privilege"bson:"privilege"`

	Solve  int `json:"solve"bson:"solve"`
	Submit int `json:"submit"bson:"submit"`

	Status int    `json:"status"bson:"status"`
	Create string `json:"create"bson:'create'`
}

type privilegeUser struct {
	user
	Index int `json:"index"bson:"index"`
}

type UserController struct {
	class.Controller
}

func (this *UserController) List(w http.ResponseWriter, r *http.Request) {
	log.Println("Admin Privilege User List")
	this.Init(w, r)

	response, err := http.Post(config.PostHost+"/user/list", "application/json", nil)
	if err != nil {
		http.Error(w, "post error", 500)
		return
	}
	defer response.Body.Close()

	one := make(map[string][]privilegeUser)
	if response.StatusCode == 200 {
		err = this.LoadJson(response.Body, &one)
		if err != nil {
			http.Error(w, "load error", 400)
			return
		}
		this.Data["User"] = one["list"]
	}

	t := template.New("layout.tpl").Funcs(template.FuncMap{
		"LargePU":     class.LargePU,
		"PriToString": class.PriToString})
	t, err = t.ParseFiles("view/admin/layout.tpl", "view/admin/user_list.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}

	this.Data["Title"] = "Privilege User List"
	this.Data["IsUser"] = true
	this.Data["IsList"] = true
	err = t.Execute(w, this.Data)
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}
}

func (this *UserController) Pagepassword(w http.ResponseWriter, r *http.Request) {
	log.Println("Admin Password Page")
	this.Init(w, r)

	var err error
	t := template.New("layout.tpl")
	t, err = t.ParseFiles("view/admin/layout.tpl", "view/admin/admin_password.tpl")
	if err != nil {
		http.Error(w, "tpl error", 500)
		return
	}

	this.Data["Title"] = "Admin Password"
	this.Data["IsSettings"] = true
	this.Data["IsSettingsPassword"] = true

	err = t.Execute(w, this.Data)
	if err != nil {
		http.Error(w, "tpl error", 400)
		return
	}
}

func (this *UserController) Password(w http.ResponseWriter, r *http.Request) {
	log.Println("Admin Password")
	this.Init(w, r)

	ok := 1
	hint := make(map[string]string)
	hint["uid"] = this.Uid //user id -> Handler

	data := make(map[string]string)
	data["userHandler"] = r.FormValue("user[Handler]")
	data["newPassword"] = r.FormValue("user[newPassword]")
	data["confirmPassword"] = r.FormValue("user[confirmPassword]")

	one := make(map[string]interface{})
	/*
		one := make(map[string]interface{})
		one["uid"] = this.Uid
		one["pwd"] = data["oldPassword"]

		reader, err := this.PostReader(&one)
		if err != nil {
			http.Error(w, "read error", 500)
			return
		}
	*/
	/*
		response, err := http.Post(config.PostHost+"/user/login", "application/json", reader)
		if err != nil {
			http.Error(w, "post error", 500)
			return
		}
		defer response.Body.Close()
	*/
	/*
		var ret user
		if response.StatusCode == 200 {
			err = this.LoadJson(response.Body, &ret)
			if err != nil {
				http.Error(w, "load error", 400)
				return
			}
		}
	*/
	/*
		if ret.Uid == "" {
			ok, hint["oldPassword"] = 0, "Old Password is Incorrect."
		}
	*/
	if len(data["newPassword"]) < 6 {
		ok, hint["newPassword"] = 0, "Password should contain at least six characters."
	}
	if data["newPassword"] != data["confirmPassword"] {
		ok, hint["confirmPassword"] = 0, "Confirmation mismatched."
	}

	if ok == 1 {
		one["pwd"] = data["newPassword"]
		reader, err := this.PostReader(&one)
		if err != nil {
			http.Error(w, "read error", 500)
			return
		}

		response, err := http.Post(config.PostHost+"/admin/user/password/reset/uid/"+this.Uid, "application/json", reader)
		if err != nil {
			http.Error(w, "post error", 400)
			return
		}
		defer response.Body.Close()

		w.WriteHeader(200)
	} else {
		b, err := json.Marshal(&hint)
		if err != nil {
			http.Error(w, "json error", 400)
			return
		}

		w.Write(b)
		w.WriteHeader(400)
	}
}

func (this *UserController) Privilege(w http.ResponseWriter, r *http.Request) {

}
