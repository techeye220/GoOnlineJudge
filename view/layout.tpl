<!DOCTYPE HTML>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>{{.Title}}</title>

    <link rel="shortcut icon" href="/static/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="/static/css/materialize.min.css" type="text/css">
    <link rel="stylesheet" href="/static/css/custom.css" type="text/css">
    <script src="/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="/static/js/materialize.min.js" type="text/javascript"></script>
    <script src="/static/js/custom.js" type="text/javascript"></script>

    {{if .IsCode}}
      <link href="/static/prettify/prettify.css" rel="stylesheet" type="text/css">
      <script src="/static/prettify/prettify.js" type="text/javascript"></script>
    {{end}}
  </head>

  <body {{if .IsCode}}onload="prettyPrint()"{{end}}>
    <header>
      <ul id="user-dropdown" class="dropdown-content">
        {{if .IsCurrentUser}}
          <li><a href="/settings">Profile</a></li>
          {{if .IsShowAdmin}}<li><a href="/admin">Admin</a></li>{{end}}
          {{if .IsShowTeacher}}<li><a href="/admin">Teacher</a></li>{{end}}
          <li class="divider"></li>
          <li><a id="user-signout" href="#">Sign Out</a></li>
        {{else}}
          <li><a href="/sess">Sign In</a></li>
          <li><a href="/users/new">Sign Up</a></li>
        {{end}}
      </ul>
      <nav>
        <div class="container">
          <div class="nav-wrapper">
            <div class="col s12">
              <a href="/" class="left brand-logo">ZJGSU</a>
              <ul class="right hide-on-med-and-down">
                <li {{if .IsNews}}class="active"{{end}}><a href="/">Home</a></li>
                <li {{if .IsProblem}}class="active"{{end}}><a href="/problems">Problems</a></li>
                <li {{if .IsStatus}}class="active"{{end}}><a href="/status">Status</a></li>
                <li {{if .IsRanklist}}class="active"{{end}}><a href="/ranklist">Ranklist</a></li>
                <li {{if .IsContest}}class="active"{{end}}><a href="/contests">Contests</a></li>
                <li {{if.IsOSC}}class="active"{{end}}><a href="/osc">OSC</a></li>
                <li {{if.IsFAQ}}class="active"{{end}}><a href="/faq">FAQ</a></li>
                <li>
                  <a class="dropdown-button" href="#" data-activates="user-dropdown">
                    <i class="mdi-action-account-circle"></i>
                    <i class="mdi-navigation-arrow-drop-down"></i>
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </nav>
    </header>

    <main>
      <div class="container">
        {{template "content" .}}
      </div>
    </main>

    <footer class="page-footer">
      <div class="container">
        <div class="row">
          <div class="col s9 left">
            <h5 class="white-text">About Us</h5>
            <p class="grey-text text-lighten-3"></p>
          </div>
          <div class="col s3 right">
            <h5 class="white-text">Developers</h5>
            <ul>
              <li><a class="grey-text text-lighten-3" href="https://github.com/memelee" target="_blank">@ lzt163</a></li>
              <li><a class="grey-text text-lighten-3" href="https://github.com/sakeven" target="_blank">@ sakeven</a></li>
              <li><a class="grey-text text-lighten-3" href="https://github.com/JinweiClarkChao" target="_blank">@ JinweiClarkChao</a></li>
              <li><a class="grey-text text-lighten-3" href="https://github.com/rex-zsd" target="_blank">@ rex-zsd</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="footer-copyright">
        <div class="container">
        <span class="left grey-text text-lighten-4">Copyright © 2013-2014 ZJGSU ACM Club</span>
        <span class="right grey-text text-lighten-4" href="#!">Version 15.01.31</span>
        </div>
      </div>
    </footer>
  </body>
</html>

