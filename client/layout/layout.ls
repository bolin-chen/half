Template['layout'].events {
  'click button.logout': (event)!-> Meteor.logout!
  'click .ui.attached.right.button': (event)!-> $ '.ui.sidebar' .sidebar ({overlay:false}) .sidebar ('toggle')
}