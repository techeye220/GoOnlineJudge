{{define "content"}}
  <div class="row">
    <div class="col s12">
      <h3 class="header">Ranklist</h3>
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
      </div>

      <div class="card-panel">
        <table id="ranklist-list" class="bordered hoverable">
          <thead>
            <tr>
              <th class="center-align">Rank</th>
              <th class="center-align">User</th>
              <th class="center-align">Nickname</th>
              <th class="center-align">Motto</th>
              <th class="center-align">Ratio(Solve/Submit)</th>
            </tr>
          </thead>
          <tbody>
            {{with .User}}
              {{range .}}
                {{if ShowStatus .Status}}
                  <tr>
                    <td class="center-align">{{.Index}}</td>
                    <td class="center-align"><a href="/users/{{.Uid}}">{{.Uid}}</a></td>
                    <td class="center-align">{{.Nick}}</td>
                    <td id="motto" >{{.Motto}}</td>
                    <td class="center-align">{{ShowRatio .Solve .Submit}} (<a href="/status?uid={{.Uid}}&judge=3">{{.Solve}}</a>/<a href="/status?uid={{.Uid}}">{{.Submit}}</a>)</td>
                  </tr>
                {{end}}
              {{end}}  
            {{end}}
          </tbody>
        </table>
      </div>
    </div>
  </div>
{{end}}