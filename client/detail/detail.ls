Template['detail'].helpers {

}

Template['detail'].events {
  'click img.firstImage': (event)!-> voteForImage choice = 'first'

  'click img.secondImage': (event)!-> voteForImage choice = 'second'

}
voteForImage = (choice)!->
  voteId = $ 'input[name=voteId]' .val!
  username = Meteor.user! .username

  console.log '-------------------------'
  console.log voteId
  console.log username
  console.log (Ballots.find-one {voteId, username})
  console.log '-------------------------'

  if not Ballots.find-one {voteId, username}
    Ballots.insert {
      voteId: voteId
      choice: choice
      username: username
    }

    if choice is 'first' then Votes.update voteId, $inc: 'numOfFirst': 1
    else Votes.update voteId, $inc: 'numOfSecond': 1