{{define "content"}}
  <div class="row">
    <div class="col s12">
      <h3 class="header">News List</h3>
      <div class="card-panel">
        {{with .News}}
          {{range .}}
            {{if ShowStatus .Status}}
              <div class="row">
                <div class="flow-text col s12">
                  <span class="left"><a href="/news/{{.Nid}}">{{.Title}}</a></span>
                  <span class="right grey-text">{{.Create}}</span>
                </div>
              </div>
            {{end}}
          {{end}}
        {{end}}
      </div>
    </div>
  </div>
{{end}}
