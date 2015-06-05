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
        type: 'empty',
        prompt: 'Title 不能为空'
      }]
    },
    firstDescription: {
      identifier: 'firstDescription'
      rules: [{
        type: 'empty',
        prompt: '第一幅图的描述不能为空'
      }]
    },
    secondDescription: {
      identifier: 'secondDescription'
      rules: [{
        type: 'empty',
        prompt: '第二幅图的描述不能为空'
      }]
    },
    question: {
      identifier: 'question'
      rules: [{
        type: 'empty',
        prompt: 'Question 不能为空'
      }]
    }})