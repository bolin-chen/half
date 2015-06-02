Template['votelist'].onRendered !->
  Session.set 'category', 'all'
  Session.set 'sortBy', 'initiateDate'


Template['votelist'].helpers {
  votelist: ->
    category = Session.get 'category'
    sortBy = Session.get 'sortBy'

    if category is 'all' then selector =  {}
    else selector = {category: category}

    options = {sort: {}}
    if sortBy isnt 'initiateDate' then options.sort[sortBy] = -1

    options.sort['initiateDate'] = -1

    Votes.find selector, options

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

  'change select[name=category]': (event)!->
    console.log event.target.value
    Session.set 'category', event.target.value

  'change select[name=sortBy]': (event)!->
    console.log event.target.value
    Session.set 'sortBy', event.target.value
}