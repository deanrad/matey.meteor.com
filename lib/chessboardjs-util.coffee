# We use ChessboardJS for its cool rendering, but
# we need methods for getting back and forth between
# our data model and theirs.
#
# Convert our piece structure:
# ````
# {role: 'rook', side: 'white', which: 'queenside'}
# ````
# into theirs
# ````
# 'wR'
# ````
# Both are keyed on string keys such as `a2`
ChessBoardJSUtil =
  fromMatey:
    piece: (piece) ->
      side = piece.side[0]
      role = if piece.role is 'knight' then 'N' else piece.role[0].toUpperCase()
      side+role
    board: (board) ->
      newboard = {}
      for pos, piece of board
        newboard[pos] = @piece(piece)
      newboard

@ChessBoardJSUtil = ChessBoardJSUtil
