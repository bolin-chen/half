Router.configure layoutTemplate: 'layout'

Router.on-before-action !->
  unless Meteor.user-id! then @redirect '/sign'
  @next!

Router.on-after-action !-> document.title = 'Black Or White'

Router.route '/', !-> @render 'homepage'

Router.route '/initiate', !-> @render 'initiate'

Router.route '/detail/:id', !->
  Session.set 'voteId', @params.id
  @render 'detail'

Router.route '/sign' !->
  if Meteor.user-id! then @redirect '/'

  Session.set 'signMode', 'signin'
  @render 'sign'

Router.route '/profile/:username' !->
  Session.set 'username', @params.username
  @render 'profile'

Router.route '/editprofile' !-> @render 'editprofile'

Router.route '/editvote/:id', !->
  Session.set 'voteId', @params.id
  @render 'editvote'

Router.route '/followingvote' !-> @render 'followingvote'