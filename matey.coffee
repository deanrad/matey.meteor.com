Router.map ->
  @route "home",
    path: "/"

Meteor.atServer ->
  Gamestates = new Meteor.Collection "gameStates"
  Meteor.publish "gameStates", ->
    @added "gameStates", 1, GameState.initialBoard

Meteor.atClient ->
  Meteor.subscribe "gameStates"

  Template.board.rendered = ->
    console.debug("Rendering chessboard.js board")
    new ChessBoard "chessboard-js-board",
     draggable: true
     position: 'start'
