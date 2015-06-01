Template['layout'].events {
  'click a.logout': (event)!-> Meteor.logout!

  'click .sidebarButton': (event)!-> $ '.ui.sidebar' .sidebar ('toggle')
}