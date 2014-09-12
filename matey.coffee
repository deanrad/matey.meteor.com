Meteor.atServer ->
  Gamestates = new Meteor.Collection "gameStates"
  Meteor.publish "gameStates", ->
    @added "gameStates", 1, GameState.initialBoard

Meteor.atClient ->
  Meteor.subscribe "gameStates"
