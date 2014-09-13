# # GameState
#
# Inspired by [FEN](en.wikipedia.org/wiki/Forsyth–Edwards_Notation),
# a GameState is an object with fields:
#
# * board: the state of the board
# * graveyard: any captured pieces
# * mover: whose turn it is to move
class GameState
  @initialState =
    mover: 'white'
    board:
      a1: {role: 'rook', side: 'white', which: 'queenside'}
      b1: {role: 'knight', side: 'white', which: 'queenside'}
      c1: {role: 'bishop', side: 'white', which: 'queenside'}
      d1: {role: 'queen', side: 'white'}
      e1: {role: 'king', side: 'white'}
      f1: {role: 'bishop', side: 'white', which: 'kingside'}
      g1: {role: 'knight', side: 'white', which: 'kingside'}
      h1: {role: 'rook', side: 'white', which: 'kingside'}

      a2: {role: 'pawn', side: 'white', which: 'a'}
      b2: {role: 'pawn', side: 'white', which: 'b'}
      c2: {role: 'pawn', side: 'white', which: 'c'}
      d2: {role: 'pawn', side: 'white', which: 'd'}
      e2: {role: 'pawn', side: 'white', which: 'e'}
      f2: {role: 'pawn', side: 'white', which: 'f'}
      g2: {role: 'pawn', side: 'white', which: 'g'}
      h2: {role: 'pawn', side: 'white', which: 'h'}

      a7: {role: 'pawn', side: 'black', which: 'a'}
      b7: {role: 'pawn', side: 'black', which: 'b'}
      c7: {role: 'pawn', side: 'black', which: 'c'}
      d7: {role: 'pawn', side: 'black', which: 'd'}
      e7: {role: 'pawn', side: 'black', which: 'e'}
      f7: {role: 'pawn', side: 'black', which: 'f'}
      g7: {role: 'pawn', side: 'black', which: 'g'}
      h7: {role: 'pawn', side: 'black', which: 'h'}

      a8: {role: 'rook', side: 'black', which: 'queenside'}
      b8: {role: 'knight', side: 'black', which: 'queenside'}
      c8: {role: 'bishop', side: 'black', which: 'queenside'}
      d8: {role: 'queen', side: 'black'}
      e8: {role: 'king', side: 'black'}
      f8: {role: 'bishop', side: 'black', which: 'kingside'}
      g8: {role: 'knight', side: 'black', which: 'kingside'}
      h8: {role: 'rook', side: 'black', which: 'kingside'}

    graveyard:
      white: {}
      black: {}

@GameState = GameState #export throughout our app
