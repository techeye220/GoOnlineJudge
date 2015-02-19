{{define "content"}}
  <div class="row">
    <div class="col s12">
      <h3 class="header">Sign In</h3>
      <div class="card-panel">
        <form id="user-signin" accept-charset="UTF-8">
          <div class="row">
            <div class="input-field col s6">
              <input id="user-account" name="user[handle]" type="text" required>
              <label for="user-account">Account</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s6">
              <input id="user-password" name="user[password]" type="text" required>
              <label for="user-password">Password</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s2">
              <button class="btn waves-effect waves-light" type="submit">Submit</button>
            </div>
            <div class="input-field col s4">
              <a class="waves-effect waves-teal btn-flat" href="/users/new">Register a new account</a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
{{end}}
