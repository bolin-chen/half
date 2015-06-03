Template['followingvote'].helpers {
  votes: ->
    unless Meteor.user! then return

    SubscribeVotes.findOne {username: Meteor.user!.username} .votes

  singleVote: (voteId)->
    unless Meteor.user! then return

    vote = Votes.findOne voteId

    unless vote then Meteor.call 'pullFromSubscribeVotes', Meteor.user!.username, voteId
    else vote
}