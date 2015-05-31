Template['layout'].events {
  'click button.logout': (event)!-> Meteor.logout!
  'click .item.sidebarButton': (event)!-> $ '.ui.sidebar' .sidebar ('toggle')
}