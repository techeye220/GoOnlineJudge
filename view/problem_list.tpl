{{define "content"}}
  <div class="row">
    <div class="col s12">
      <h3 class="header">Problems List</h3>
      <div class="card-panel">
        <div class="row">
          <div class="col s12">
            {{$current := .CurrentPage}}
            {{$url := .URL}}

            {{if .IsPreviousPage}}
            <a class="waves-effect waves-teal btn-flat btn-page" href="{{$url}}page={{NumSub .CurrentPage 1}}"><i class="mdi-navigation-arrow-back"></i></a>
            {{else}}
            <a class="btn-flat btn-page disabled"><i class="mdi-navigation-arrow-back"></i></a>
            {{end}}

            {{if .IsPageHead}}
              {{with .PageHeadList}}
                {{range .}}
                  {{if eq . $current}}
                    <a class="btn-flat btn-page disabled">{{.}}</a>
                  {{else}}
                    <a class="waves-effect waves-teal btn-flat btn-page" href="{{$url}}page={{.}}">{{.}}</a>
                  {{end}}
                {{end}}
              {{end}}
            {{end}}

            {{if .IsPageMid}}
              <a class="btn-flat btn-page disabled">...</a>
              {{with .PageMidList}}
                {{range .}}
                  {{if eq . $current}}
                    <a class="btn-flat btn-page disabled">{{.}}</a>
                  {{else}}
                    <a class="waves-effect waves-teal btn-flat btn-page" href="{{$url}}page={{.}}">{{.}}</a>
                  {{end}}
                {{end}}
              {{end}}
            {{end}}

            {{if .IsPageTail}}
              <a class="btn-flat btn-page disabled">...</a>
              {{with .PageTailList}}
                {{range .}}
                  {{if eq . $current}}
                    <a class="btn-flat btn-page disabled">{{.}}</a>
                  {{else}}
                    <a class="waves-effect waves-teal btn-flat btn-page" href="{{$url}}page={{.}}">{{.}}</a>
                  {{end}}
                {{end}}
              {{end}}
            {{end}}

            {{if .IsNextPage}}
            <a class="waves-effect waves-teal btn-flat btn-page" href="{{$url}}page={{NumAdd .CurrentPage 1}}"><i class="mdi-navigation-arrow-forward"></i></a>
            {{else}}
            <a class="btn-flat btn-page disabled"><i class="mdi-navigation-arrow-forward"></i></a>
            {{end}}
          </div>
        </div>
        <form id="problem-search" accept-charset="UTF-8">
          <div class="row">
            <div class="input-field col s4">
              <input id="search" name="search" type="text" required>
              <label for="search">Search</label>
            </div>
            <div class="col s4">
              <select id="option" name="option">
                <option value="title" {{if .SearchTitle}}selected{{end}}>Title</option>
                <option value="pid" {{if .SearchPid}}selected{{end}}>ID</option>
                <option value="source" {{if .SearchSource}}selected{{end}}>Source</option>
              </select>
            </div>
            <div class="input-field col s4">
              <button class="btn waves-effect waves-light" type="submit">Go</button>
            </div>
          </div>
        </form>
      </div>

      <div class="card-panel">
        <table id="problem-list" class="bordered hoverable">
          <thead>
            <tr>
              <th class="center-align">ID</th>
              <th class="center-align">Title</th>
              <th class="center-align">Ratio (Solve/Submit)</th>
              <th class="center-align">OJ</th>
              <th class="center-align">VPID</th>
            </tr>
          </thead>
          <tbody>
            {{$time := .Time}}
            {{$privilege := .Privilege}}

            {{with .Problem}}  
              {{range .}} 
                {{if or (ShowStatus .Status) (LargePU $privilege)}}
                  {{/*if ShowExpire .Expire $time*/}}
                    <tr>
                      <td class="center-align">{{.Pid}}</td>
                      <td><a href="/problems/{{.Pid}}">{{.Title}}</a></td>
                      <td class="center-align">{{ShowRatio .Solve .Submit}} (<a href="/status?pid={{.Pid}}&judge=3">{{.Solve}}</a>/<a href="/status?pid={{.Pid}}">{{.Submit}}</a>)</td>
                      <td class="center-align">{{if .ROJ}}{{.ROJ}}{{else}}Local{{end}}</td>
                      <td class="center-align">{{.RPid}}</td>
                    </tr>
                  {{/*end*/}}
                {{end}}
              {{end}}  
            {{end}}
          </tbody>
        </table>
      </div>
    </div>
  </div>
{{end}}
