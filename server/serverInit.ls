Meteor.methods {
  removeBallots: (selector)!-> Ballots.remove selector

  removeComments: (selector)!-> Comments.remove selector

  removeReports: (selector)!-> Reports.remove selector

  pushToFollowers: (username, followerName, followerId)!->
    Follows.update {username}, $push: followers: {username: followerName}

  pullFromFollowers: (username, followerName)!->
    Follows.update {username}, $pull: followers: {username: followerName}

  pushToSubscribeVotes: (username, voteId)!->
    SubscribeVotes.update {username}, $push: votes: {$each: [{voteId}], $slice: -30}

  pullFromSubscribeVotes: (username, voteId)!->
    SubscribeVotes.update {username}, $pull: votes: {voteId}
}