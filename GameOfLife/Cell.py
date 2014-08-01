class Cell:
    def __init__(self, x, y, cellSize, state):
        self.x = x
        self.y = y
        self.w = cellSize
        self.neighbors = []
        self.state = state
        self.nextState = False
    
    def addNeighbor(self, cell):
        self.neighbors.append(cell)
        
    def display(self):
        self.state = self.nextState
        if self.state:
            fill(140)
            x = self.x * self.w
            y = self.y * self.w
            rect(x, y, self.w * .5, self.w * .5)
        
    def getNextState(self):
        liveNeighbors = sum(1 for cell in self.neighbors if cell.state)
        self.nextState = (liveNeighbors == 2 and self.state) or (liveNeighbors == 3)
