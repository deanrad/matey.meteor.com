# This defines the core Meteoric logic of our player-to-player Chess
# game, *Matey*

# Set up the default route, to be rendered after our subscription is ready
Router.map ->
  @route "home",
    path: "/"
    waitOn: -> Meteor.subscribe "boards"

# Create and publish a collection of Boards.
# Add a single board representing the start of a game
if Meteor.isServer
  Boards = new Meteor.Collection "boards"

  if Boards.find().count() is 0
    Boards.insert Board.initialBoard

  Meteor.publish "boards", ->
    Boards.find()

  Meteor.methods
    reset: ->
      Boards.remove {} #all
      Boards.insert Board.initialBoard

# Subscribe to the Boards collection
if Meteor.isClient
  Meteor.subscribe "boards"
  Boards = new Meteor.Collection "boards"
  @Boards = Boards # make available in browser for debugging

  # Tell Meteor that whenever anything changes, rerun
  # the function which populates the ChessBoard.JS board
  # with the most recent one in our subscription.
  # Critically, the first line establishes a dependency
  # on the count of the # of boards, causing this function
  # to be rerun whenever that count changes.
  Deps.autorun (c)->
    state_count = Boards.find().count()

    unless c.firstRun
      console.debug("Reactive data change detected")
      console.debug("Board count is #{state_count-1}")

      latest = _.last(Boards.find().fetch())
      if latest
        Board.render(latest)

  Template.newGame.events
    'click #reset': ->
      console.log "Resetting"
      Meteor.call "reset"
