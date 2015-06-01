Template['votelist'].helpers {
  votelist: -> Votes.find {}
}

Template['votelist'].events {
  'submit form.deleteForm': (event)!->
    event.preventDefault!

    voteId = event.target.voteId.value
    firstImageId = event.target.firstImageId.value
    secondImageId = event.target.secondImageId.value

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

  'submit form.statusForm': (event)!->
    event.preventDefault!

    voteId = event.target.voteId.value

    isOpen = Votes.findOne voteId .isOpen
    Votes.update voteId, $set: isOpen: !isOpen
}