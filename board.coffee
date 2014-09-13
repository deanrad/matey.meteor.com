class Board
  clientId = "chessboard-js-board"
  @render = (board) ->
    console.info("Rendering board")
    new ChessBoard clientId,
      draggable: true
      onDrop: (source, target) ->
        console.log "Moving from #{source} to #{target}"
      position: ChessBoardJSUtil.fromMatey.board(board)

@Board=Board
