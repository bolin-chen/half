Template['sign'].onRendered !->
  Session.set 'errorMessage', ''
  check-signin!
  check-register!

Template['sign'].helpers {
  isSignin: -> (Session.get 'signMode') is 'signin'
  errorMessage: -> Session.get 'errorMessage'
}

Template['sign'].events {
  'click .modeSwitch': (event)!->
    signin-form = $ 'form.signin'
    register-form = $ 'form.register'

    if (Session.get 'signMode') is 'signin'
      Session.set 'signMode', 'register'
      $ '.modeSwitch' .text '登录'

      signin-form.add-class 'hide'
      register-form.remove-class 'hide'

      signin-form.form 'reset'
    else
      Session.set 'signMode', 'signin'
      $ '.modeSwitch' .text '注册'

      signin-form.remove-class 'hide'
      register-form.add-class 'hide'

      register-form.form 'reset'

  'submit form.signin': (event)!->
    event.prevent-default!

    username = event.target.username.value
    password = event.target.password.value
    Meteor.loginWithPassword username, password, (err)!->
      if err then Session.set 'errorMessage', err.message
      else Router.go '/'

  'submit form.register': (event)!->
    event.prevent-default!

    username = event.target.username.value
    password = event.target.password.value
    confirm = event.target.confirm.value
    if password isnt confirm
      Session.set 'errorMessage', '两次输入的密码不一致'
      return

    userOption = {
      username: username
      password: password
      profile:
        nickname: ''
        gender: ''
        age: 0
        occupation: ''
        avatarUrl: '/defaultAvatar.jpg'
        avatarId: ''
    }

    Accounts.createUser userOption, (err)!->
      if err then Session.set 'errorMessage', err.message
      else Router.go '/'
}

#以下叶炽凯添加的代码

#登录验证
check-signin =!->
  console.log 'function run'
  $ '#sign .ui.form.signin' .form ({
    username: {
      identifier: 'username',
      rules: [{
        type: 'empty'
        prompt: 'Please enter your username'
      }]
    },
    password: {
      identifier: 'password',
      rules: [{
        type: 'empty'
        prompt: 'Please enter your password'
      }]
    }})

#注册验证
check-register =!->
  $ '#sign .ui.form.register' .form ({
    username: {
      identifier: 'username',
      rules: [{
        type: 'empty'
      },
      {
        type: 'length[3]'
      }]
    },
    password: {
      identifier: 'password',
      rules: [{
        type: 'empty'
      },
      {
        type: 'length[3]'
      }]
    },
    confirm: {
      identifier: 'confirm',
      rules: [{
        type: 'empty'
      },{
        type: 'match[password]'
      }]
    }})