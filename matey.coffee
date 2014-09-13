# This defines the core Meteoric logic of our player-to-player Chess
# game, *Matey*

# Set up the default route, to be rendered after our subscription is ready
Router.map ->
  @route "home",
    path: "/"
    waitOn: -> Meteor.subscribe "gameStates"

# Create and publish a collection of GameStates,
# Manually publish a single one for now
if Meteor.isServer
  Gamestates = new Meteor.Collection "gameStates"

  Meteor.publish "gameStates", ->
    @added "gameStates", 1, GameState.initialState
    @ready()

# Subscribe to the Gamestates collection
if Meteor.isClient
  Meteor.subscribe "gameStates"
  Gamestates = new Meteor.Collection "gameStates"
  @Gamestates = Gamestates # make available in browser for debugging

  # Tell Meteor that whenever anything changes, rerun
  # the function which populates the ChessBoard.JS board
  # with the most recent one in our subscription.
  # Critically, the first line establishes a dependency
  # on the count of the # of gamestates, causing this function
  # to be rerun whenever that count changes.
  Deps.autorun (c)->
    board_count = Gamestates.find().count()
    if !c.firstRun and board_count > 0
      console.debug("Reactive data change detected")
      console.debug("Board count is #{board_count}")
      board = Gamestates.find().fetch()[board_count-1].board
      console.info("Rendering chessboard.js board")
      new ChessBoard "chessboard-js-board",
        draggable: true
        position: ChessBoardJSUtil.fromMatey.board(board)
