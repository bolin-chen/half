Template['editvote'].onRendered !->
  check-form!

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
      modifyDate: new Date!
      firstDescription: event.target.firstDescription.value
      secondDescription: event.target.secondDescription.value
      question: event.target.question.value
    }

    Router.go ('/detail/' + voteId)
}


#验证发起投票的表单
check-form =!->
  console.log 'check-form'
  $ '#editvote .ui.form.editvote' .form({
    title: {
      identifier: 'title'
      rules: [{
        type: 'empty'
        prompt: 'empty title'   #可以在这里添加提示（暂时不能显示，将会解决）
      }]
    },
    firstDescription: {
      identifier: 'firstDescription'
      rules: [{
        type: 'empty'
      }]
    },
    secondDescription: {
      identifier: 'secondDescription'
      rules: [{
        type: 'empty'
      }]
    },
    question: {
      identifier: 'question'
      rules: [{
        type: 'empty'
      }]
    }})