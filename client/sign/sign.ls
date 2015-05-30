Template['sign'].onRendered !->
  Session.set 'errorMessage', ''

Template['sign'].helpers {
  isSignin: -> (Session.get 'signMode') is 'signin'
  errorMessage: -> Session.get 'errorMessage'
}

Template['sign'].events {
  'click .modeSwitch': (event)!->
    if (Session.get 'signMode') is 'signin'
      Session.set 'signMode', 'register'
      $ '.modeSwitch' .text '登录'
    else
      Session.set 'signMode', 'signin', (err)!->
        console.log 'err: ' + err
      $ '.modeSwitch' .text '注册'

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