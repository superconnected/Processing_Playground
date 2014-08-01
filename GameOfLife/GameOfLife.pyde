from Cell import Cell

showIterations = False
paused = False

cells = []
rows = 0
cols = 0
cellSize = 10

def setup():
    size(500,500)
    frameRate(10)
    
    rows = int(width/cellSize)
    cols = int(height/cellSize)
    
    cells = [[Cell(x, y, cellSize, random(1) > .8) for y in range(cols)] for x in range(rows)]
    
    for x in range(rows):
        for y in range(cols):
            above = x - 1 if x > 0 else rows - 1
            below = x + 1 if x < rows - 1 else 0
            left = y - 1 if y > 0 else cols - 1
            right = y + 1 if y < cols - 1 else 0
            
            cell = cells[x][y]
            cell.addNeighbor(cells[x][left])
            cell.addNeighbor(cells[x][right])
            cell.addNeighbor(cells[above][y])
            cell.addNeighbor(cells[below][y])
            cell.addNeighbor(cells[above][left])
            cell.addNeighbor(cells[above][right])
            cell.addNeighbor(cells[below][left])
            cell.addNeighbor(cells[below][right])
            
def draw():
    #background(255)
    rectMode(CENTER)
    fill(255,255,255,200)
    rect(width/2, height/2, width, height)
    
    offset = cellSize/2
    translate(offset, offset)
    #stroke(255)
    noStroke()
    
    for cell in each_cell():
        cell.getNextState()
        
    for cell in each_cell():
        cell.display()
    
    if showIterations:
        translate(-offset,-offset)
        rectMode(CORNER)    
        fill(0, 0, 0, 175)
        txt = "iterations: " + str(frameCount)
        rect(0, 0, textWidth(txt) + 20, 20)
        fill(255)
        text(txt, 10, 13)
            
def each_cell():
    for x in range(rows):
        for y in range(cols):
            yield cells[x][y]
            
def keyPressed():
    if key == 'i' or key == 'I':
        showIterations = not showIterations
    
    if key == ' ':
        paused = not paused
        if paused:
            noLoop()
        else:
            loop()
