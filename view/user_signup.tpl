{{define "content"}}
  <div class="row">
    <div class="col s12">
      <h3 class="header">Sign Up</h3>
      <div class="card-panel">
        <form id="user-signup" accept-charset="UTF-8">
          <div class="row">
            <div class="input-field col s6">
              <input id="user-account" name="user[handle]" type="text" required>
              <label for="user-account">Accunt</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s6">
              <input id="user-nickname" name="user[nick]" type="text" required>
              <label for="user-nickname">Nickname</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s6">
              <input id="user-password" name="user[password]" type="password" required>
              <label for="user-password">Password</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s6">
              <input id="user-comfirm" name="user[confirmPassword]" type="password" required>
              <label for="user-comfirm">Confirm Password</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s6">
              <input id="user-email" name="user[mail]" type="email">
              <label for="user-email">Email</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s6">
              <input id="user-school" name="user[school]" type="text">
              <label for="user-school">School</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s6">
              <input id="user-motto" name="user[motto]" type="text">
              <label for="user-motto">Motto</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s2">
              <button class="btn waves-effect waves-light" type="submit">Submit</button>
            </div>
            <div class="input-field col s4">
              <a class="waves-effect waves-teal btn-flat" href="/sess">Already have an account</a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
{{end}}