# This defines the core Meteoric logic of our player-to-player Chess
# game, *Matey*

# We view a game as a collection of Boards, each move creating a
# new board. The most recent one in this collection is the view
# we see, but we have each previous board.
@Boards = new Meteor.Collection "boards"


# Set up the default route, to be rendered after our subscription is ready
Router.map ->
  @route "home",
    path: "/"
    waitOn: -> Meteor.subscribe "boards"

# Create and publish a collection of Boards.
# Add a single board representing the start of a game
if Meteor.isServer
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

  # Tell Meteor that whenever anything changes, rerun
  # the function which populates the ChessBoard.JS board
  # with the most recent one in our subscription.
  Boards.find().observeChanges
    added: ->
      console.log("reacting to new move")
      board = _.last(Boards.find().fetch())
      Board.render(board) if board
      
  Template.newGame.events
    'click #reset': ->
      console.log "Resetting"
      Meteor.call "reset"
