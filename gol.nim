import sequtils

proc getLiveNeighbors(grid: seq[seq[bool]], x: int, y: int): int = 
  result = 0
  for i in -1..1:
    for j in -1..1:
      if y+i >= 0 and y+i <= grid.len-1 and x+j >= 0 and x+j <= grid[0].len-1: #keep checks bound to grid
        if i != 0 or j != 0:
          if grid[y+i][x+j] == true:
            inc result

proc nextGrid(grid: seq[seq[bool]]): seq[seq[bool]] =
  result = newSeqWith(grid.len, newSeq[bool](grid[0].len))
  for y in 0..grid.len-1:
    for x in 0..grid[0].len-1:
      var liveNeighbors = getLiveNeighbors(grid, x, y)
      if grid[y][x]: #if the cell is alive
        if liveNeighbors != 2 and liveNeighbors != 3:
          result[y][x] = false
        else:
          result[y][x] = true
      else: #if it is dead
        if liveNeighbors == 3:
          result[y][x] = true
        else:
          result[y][x] = false

proc drawGrid(grid: seq[seq[bool]]) =
  for i in grid:
    for j in i:
      if j:
        write(stdout, "██")
      else:
        write(stdout, "  ")
    echo()

var grid = @[

    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, true, true, false, false, false, false, false, false],
    @[false, false, false, false, false, true, true, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, true, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
    @[false, false, false, false, false, false, false, false, false, false, false, false, false, false]]


while true:
  drawGrid(grid)
  write(stdout, "Press enter for next frame...")
  echo readLine(stdin)
  grid = nextGrid(grid)
