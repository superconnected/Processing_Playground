# Invaders
# Randomly generates a number of Space Invaders-style pixelated sprites
# by Josh Daniels (superconnected@gmail.com) 

cell_rows = 8 # rows of cells in the invader
cell_cols = 8 # columns of cells in the invader
cell_size = 5 # size in pixels of each cell in the invader
gutter = 9 # space between invaders in the window
v_invaders = 0 # number of invaders that can fit vertically in the window
h_invaders = 0 # number of invaders that can fit horizontall in the window

def setup():
    size(600,600)
    background(255)
    noStroke()
    
    v_invaders = floor(height/((cell_rows * cell_size) + gutter))
    h_invaders = floor(width/((cell_cols * cell_size) + gutter))
    
    colorMode(HSB)
    draw_invaders()
            
def draw():
    pass

def mousePressed():
    background(255)
    draw_invaders()
    
def draw_invaders():
    for i in range(v_invaders):
        y = gutter + (i * cell_rows * cell_size) + (gutter * i)
        for j in range(h_invaders):
            x = gutter + (j * cell_cols * cell_size) + (gutter * j)
            fill(random(255), 150 + random(105), 155 + random(100))
            draw_invader(x, y) 
                
def draw_invader(x, y):
    invader = horizontally_mirrored(generate_invader_half())
    draw_cells(invader, x, y)

def generate_invader_half():
    # simple random fill
    return [[round(random(1)) == 1 for j in range(floor(cell_cols/2))] for i in range(cell_rows)]

def horizontally_mirrored(lst):
    mirrored = []
    for row in lst:
        rev = list(row)
        rev.reverse()
        mirrored.append(row + rev)
    return mirrored
    
def draw_cells(cells, x, y):
    pushMatrix()
    translate(x,y)
    
    y = 0
    for row in cells:
        x = 0
        for col in row:
            if col:
                rect(x * cell_size, y * cell_size, cell_size, cell_size)
            x += 1
        y += 1
            
    popMatrix()
