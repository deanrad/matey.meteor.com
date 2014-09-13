# `Board` deals with rendering boards and listening to
# events generated by the boards, aka _moves_
class Board
  clientId = "chessboard-js-board"

  #Renders a ChessBoardJS board from a Matey model
  #Attaches an event handler that says:
  #> Add a GameState which takes into account the move that was made.
  @render = (gameState) ->
    console.info("Rendering board")
    new ChessBoard clientId,
      draggable: true
      onDrop: (source, target) ->
        console.log "Moving from #{source} to #{target}"
        GameStates.insert Board.move(gameState, source, target)
      position: ChessBoardJSUtil.fromMatey.board(gameState.board)

  # Takes a GameState, returns a new one on which the move has been played.
  @move = (state, from, to) ->
    newBoard = _.clone(state.board)
    mover = newBoard[from]
    delete newBoard[from]
    newBoard[to] = mover
    {
      board: newBoard
    }

@Board=Board