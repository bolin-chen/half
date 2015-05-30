Template['detail'].helpers {
  vote: -> Votes.findOne (Session.get 'voteId')
}

Template['detail'].events {
  'click img.firstImage': (event)!-> voteForImage choice = 'first'

  'click img.secondImage': (event)!-> voteForImage choice = 'second'

  'submit form.deleteForm': (event)!->
    event.preventDefault!

    voteId = event.target.voteId.value
    firstImageId = event.target.firstImageId.value
    secondImageId = event.target.secondImageId.value

    Router.go '/'

    Votes.remove voteId
    Images.remove firstImageId
    Images.remove secondImageId

    Meteor.call 'removeBallots', {voteId: voteId}
    Meteor.call 'removeComments', {voteId: voteId}

  'submit form.reportForm': (event)!->
    event.preventDefault!

    voteId = event.target.voteId.value
    username = Meteor.user!.username

    if not Reports.find-one {voteId, username}
      Reports.insert {
        voteId: voteId
        username: username
      }

      Votes.update voteId, $inc: 'reportNum': 1
}

voteForImage = (choice)!->
  voteId = Session.get 'voteId'
  username = Meteor.user! .username

  # console.log '-------------------------'
  # console.log voteId
  # console.log username
  # console.log (Ballots.find-one {voteId, username})
  # console.log '-------------------------'

  if not Ballots.find-one {voteId, username}
    Ballots.insert {
      voteId: voteId
      choice: choice
      username: username
    }

    if choice is 'first' then Votes.update voteId, $inc: 'numOfFirst': 1
    else Votes.update voteId, $inc: 'numOfSecond': 1