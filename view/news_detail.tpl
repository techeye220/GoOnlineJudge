{{define "content"}}
	{{with .Detail}}
    <div class="row">
      <div class="col s12">
        <h3 class="header">News Detail</h3>
        <div class="card-panel">
		      <h4 class="page-header">{{.Title}}</h4>
		      <p><b>Date: </b>{{.Create}}</p>
          {{.Content}}
        </div>
      </div>
    </div>
	{{end}}
{{end}}