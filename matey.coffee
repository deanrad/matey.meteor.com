# This defines the core Meteoric logic of our player-to-player Chess
# game, *Matey*

# Set up the default route, to be rendered after our subscription is ready
Router.map ->
  @route "home",
    path: "/"
    waitOn: -> Meteor.subscribe "gameStates"

# Create and publish a collection of GameStates.
# Add a single Gamestate representing the start of a game
if Meteor.isServer
  GameStates = new Meteor.Collection "gameStates"

  if GameStates.find().count() is 0
    GameStates.insert GameState.initialState

  Meteor.publish "gameStates", ->
    GameStates.find()

  Meteor.methods
    reset: ->
      GameStates.remove({})
      GameStates.insert GameState.initialState

# Subscribe to the GameStates collection
if Meteor.isClient
  Meteor.subscribe "gameStates"
  GameStates = new Meteor.Collection "gameStates"
  @GameStates = GameStates # make available in browser for debugging

  # Tell Meteor that whenever anything changes, rerun
  # the function which populates the ChessBoard.JS board
  # with the most recent one in our subscription.
  # Critically, the first line establishes a dependency
  # on the count of the # of gamestates, causing this function
  # to be rerun whenever that count changes.
  Deps.autorun (c)->
    state_count = GameStates.find().count()

    unless c.firstRun
      console.debug("Reactive data change detected")
      console.debug("Board count is #{state_count-1}")

      gameState = _.last(GameStates.find().fetch())
      if gameState
        Board.render(gameState)

  Template.newGame.events
    'click #reset': ->
      console.log "Resetting"
      Meteor.call "reset"
