Template['votelist'].helpers {
  votelist: -> Votes.find {}

  orderToCategory: (order)->
    switch order
    |'categ0' => '商标设计'
    |'categ1' => '图标设计'
    |'categ2' => '软件设计'
    |'categ3' => '网页设计'
    |'categ4' => '服装设计'
    |'categ5' => '照片'
    |'categ6' => '其他'

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
    Meteor.call 'removeReports', {voteId: voteId}

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