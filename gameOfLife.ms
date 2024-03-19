clear

cellSize = 32
overlap = -1

display(5).mode = displayMode.tile
tileDisplay = display(5)
tileDisplay.tileSet = file.loadImage("/sys/pics/TileShapes.png")
tileDisplay.tileSetTileSize = 64
tileDisplay.cellSize = cellSize + overlap
tileDisplay.overlap = overlap
tileDisplay.extent = [960/cellSize, 640/cellSize]
tileDisplay.clear 1

cols = floor(960/cellSize)
rows = floor(640/cellSize)

board = []
for col in range(0, cols-1)
	board.push []
	for row in range(0, rows-1)
		board[col].push 0
	end for
end for

playButton = new Sprite
playButton.image = file.loadImage("/sys/pics/Block.png")
playButton.x = 960 - 48
playButton.y = 640 - 48
display(4).sprites.push playButton

playSprite = new Sprite
playSprite.image = file.loadImage("/sys/pics/shapes/Triangle.png")
playSprite.x = 960 - 48
playSprite.y = 640 - 48
playSprite.rotation = 270
playSprite.scale = 0.5
display(4).sprites.push playSprite

stopSprite = new Sprite
stopSprite.image = file.loadImage("/sys/pics/shapes/Square.png")
stopSprite.x = 960 - 48
stopSprite.y = 640 - 48
stopSprite.scale = 0.4
display(4).sprites.push stopSprite

playButton.handleMouseOver = function()
	if not self.localBounds then
		self.localBounds = new Bounds
		self.localBounds.width = self.image.width
		self.localBounds.height = self.image.height
	end if
	if self.contains(mouse) then
		self.tint = color.rgba(255,255,255,255)
		if not isPlaying then
			playSprite.tint = color.green
			stopSprite.tint = color.rgba(255,255,255,0)
		else
			playSprite.tint = color.rgba(255,255,255,0)
			stopSprite.tint = color.blue
		end if
	else
		self.tint = color.rgba(255,255,255,128)
		if not isPlaying then
			playSprite.tint = color.rgba(0,128,0,128)
			stopSprite.tint = color.rgba(255,255,255,0)
		else
			playSprite.tint = color.rgba(255,255,255,0)
			stopSprite.tint = color.rgba(0,0,255,128)
		end if
	end if
end function

renderBoard = function()
	for col in range(0, cols-1)
		for row in range(0, rows-1)
			if board[col][row] then
				tileDisplay.setCell col, row, 4
			else
				tileDisplay.setCell col, row, 0
			end if
		end for
	end for
end function

changeCellAt = function(pos)
	if pos[0] < 0 or pos[0] >= cols or pos[1] < 0 or pos[1] >= rows then return
	board[pos[0]][pos[1]] = not board[pos[0]][pos[1]]
end function



isPlaying = false

changePlayState = function()
	globals.isPlaying = not globals.isPlaying
end function

dirs = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
numberOfNeighbours = function(col, row, board)
	amount = 0
	for dir in dirs
		pos = [col+dir[0], row+dir[1]]
		if pos[0] < 0 then pos[0] = cols-1
		if pos[0] >= cols then pos[0] = 0
		if pos[1] < 0 then pos[1] = rows-1
		if pos[1] >= rows then pos[1] = 0
		if not board[pos[0]][pos[1]] then continue
		amount = amount + 1
	end for
	return amount
end function

nextBoard = function(oldBoard)
	newBoard = []
	for col in range(0,cols-1)
		newBoard.push []
		for row in range(0,rows-1)
			value = oldBoard[col][row]
			neighbours = numberOfNeighbours(col, row, oldBoard)
			if neighbours < 2 then value = 0
			if neighbours == 3 then value = 1
			if neighbours > 3 then value = 0
			newBoard[col].push value
		end for
	end for
	return newBoard
end function

mouseWasDown = false
lastTimestamp = time
tickTime = 0
while true
	currentTimestamp = time
	delta = currentTimestamp - lastTimestamp
	lastTimestamp = currentTimestamp
	
	if key.pressed("q") then break
	
	playButton.handleMouseOver
	
	mouseIsDown = mouse.button
	if mouseIsDown and not mouseWasDown then
		pos = [floor(mouse.x/cellSize),floor(mouse.y/cellSize)]
		if playButton.contains(mouse) then
			changePlayState
		else if not isPlaying then
			changeCellAt pos
		end if
	end if
	mouseWasDown = mouseIsDown
	
	if isPlaying then
		tickTime = tickTime + delta
		if tickTime >= 0.25 then
			board = nextBoard(board)
			tickTime = tickTime - 0.25
		end if
	end if
	renderBoard
	yield
end while

clear