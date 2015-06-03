Template['profile'].helpers {
  userId: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    user._id

  isInBlacklist: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    if Blacklist.findOne {username: user.username} then  true
    else  false

  isFollowing: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    unless Meteor.user! then return

    follower = Meteor.user!.username

    if Follows.findOne {username: user.username, followers: $elemMatch: username: follower} then true
    else  false

  following: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    Follows.find {followers: $elemMatch: username: user.username}

  followedBy: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    Follows.findOne {username: user.username} .followers

  followingNum: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    Follows.find {followers: $elemMatch: username: user.username} .count!

  followedByNum: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    Follows.findOne {username: user.username} .followers .length

  isOwnProfile: ->  if user = Meteor.users. find-one {username: Session.get 'username'}
    unless Meteor.user! then return

    user.username is Meteor.user!.username

  profile: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    user.profile

  occupation: -> if user = Meteor.users. find-one {username: Session.get 'username'}
    orderToOccupation user.profile.occupation
}

Template['profile'].events {
  'submit form.blacklistForm': (event)!->
    event.preventDefault!

    userId = event.target.userId.value
    username = Meteor.users.findOne userId .username

    blacklistInfo = Blacklist.findOne {username}

    unless blacklistInfo then Blacklist.insert {username, date: new Date!}
    else Blacklist.remove blacklistInfo._id

  'submit form.followForm': (event)!->
      event.preventDefault!

      userId = event.target.userId.value
      username = Meteor.users.findOne userId .username

      followerName = Meteor.user! .username
      followsInfo = Follows.findOne {username, followers: $elemMatch: username: Meteor.user!.username}

      unless followsInfo then Meteor.call 'pushToFollowers', username, followerName
      else Meteor.call 'pullFromFollowers', username, followerName

}

orderToOccupation = (order)->
  switch order
  | 'occup0' => '互联网科技'
  | 'occup1' => '金融'
  | 'occup2' => '信息传媒'
  | 'occup3' => '教育'
  | 'occup4' => '医疗卫生'
  | 'occup5' => '服务业'
  | 'occup6' => '地产建筑'
  | 'occup7' => '国家机关'
  | 'occup8' => '农林牧鱼'
  | 'occup9' => '制作加工'
  | otherwise => console.log 'wrong occupation order'