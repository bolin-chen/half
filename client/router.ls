Router.configure layoutTemplate: 'layout'

Router.on-after-action !-> document.title = '1/2 - Design Proposal Voting Website'

Router.route '/', !-> @render 'homepage'

Router.route '/initiate', !-> @render 'initiate'

Router.route '/detail/:id', !-> @render 'detail', data: -> Votes.find-one this.params.id