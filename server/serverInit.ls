Meteor.methods {
  removeBallots: (selector)!-> Ballots.remove selector

  removeComments: (selector)!-> Comments.remove selector
}