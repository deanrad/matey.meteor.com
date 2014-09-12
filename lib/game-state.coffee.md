# GameState

Inspired by [FEN](en.wikipedia.org/wiki/Forsyth–Edwards_Notation),
a GameState is an object such as:

    class GameState
      @initialBoard =
        turn_to_move: 'white'
        board:
          a1: {role: 'rook', side: 'white', flank: 'queen'}
          b1: {role: 'knight', side: 'white', flank: 'queen'}
          c1: {role: 'bishop', side: 'white', flank: 'queen'}
          d1: {role: 'queen', side: 'white'}
          e1: {role: 'king', side: 'white'}
          f1: {role: 'bishop', side: 'white', flank: 'king'}
          g1: {role: 'knight', side: 'white', flank: 'king'}
          h1: {role: 'rook', side: 'white', flank: 'king'}
        graveyard:
          white: {}
          black: {}
