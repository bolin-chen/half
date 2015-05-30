Template['editvote'].helpers {
  vote: -> Votes.findOne (Session.get 'voteId')
}

Template['editvote'].events {
  'submit form.editvote': (event)!->
    event.preventDefault!

    voteId = event.target.voteId.value

    Votes.update voteId, $set: {
      title: event.target.title.value
      category: event.target.category.value
      firstDescription: event.target.firstDescription.value
      secondDescription: event.target.secondDescription.value
      question: event.target.question.value
    }

    Router.go ('/detail/' + voteId)
}