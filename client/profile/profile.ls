Template['profile'].helpers {
  profile: ->
    if user = Meteor.users. find-one {username: Session.get 'username'}
      user.profile
}