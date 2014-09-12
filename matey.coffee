
Router.map ->
  @route "home",
    path: "/"
    waitOn: -> Meteor.subscribe "gameStates"

if Meteor.isServer
  Gamestates = new Meteor.Collection "gameStates"
  Meteor.publish "gameStates", ->
    @added "gameStates", 1, GameState.initialBoard

if Meteor.isClient
  Meteor.subscribe "gameStates"
  Gamestates = new Meteor.Collection "gameStates"
  @Gamestates = Gamestates

  Template.board.rendered = ->
    board = Gamestates.find().count()
    console.log("This many boards: " + board)
    console.debug("Rendering chessboard.js board")
    new ChessBoard "chessboard-js-board",
     draggable: true
     position: ChessBoardJSUtil.fromMatey.board()
