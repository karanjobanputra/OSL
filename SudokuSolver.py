 def find_empty_location(arr,emtpy_location):
    for row in range(9):
        for col in range(9):
            if(arr[row][col]==0):
                emtpy_location[0]=row
                emtpy_location[1]=col
                return True
    return False
 
def used_in_row(arr,row,num):
    for i in range(9):
        if(arr[row][i] == num):
            return True
    return False
 
def used_in_col(arr,col,num):
    for i in range(9):
        if(arr[i][col] == num):
            return True
    return False
 
def used_in_box(arr,row,col,num):
    for i in range(3):
        for j in range(3):
            if(arr[i+row][j+col] == num):
                return True
    return False
def solve_sudoku(arr):
      
    emtpy_location=[0,0]
        
    if(not find_empty_location(arr,emtpy_location)):
        return True

    row=emtpy_location[0]
    col=emtpy_location[1]
    
    for num in range(1,10):
        if(not used_in_row(arr,row,num) and not used_in_col(arr,col,num) and not used_in_box(arr,row - row%3,col - col%3,num)):
            arr[row][col]=num
            if(solve_sudoku(arr)):
                return True
            arr[row][col] = 0
                    
    return False
 
if __name__=="__main__":
     
    grid=[[0 for x in range(9)]for y in range(9)]
    grid=[[0,0,0,2,6,0,7,0,1],
          [6,8,0,0,7,0,0,9,0],
          [1,9,0,0,0,4,5,0,0],
          [8,2,0,1,0,0,0,4,0],
          [0,0,4,6,0,2,9,0,0],
          [0,5,0,0,0,3,0,2,8],
          [0,0,9,3,0,0,0,7,4],
          [0,4,0,0,5,0,0,3,6],
          [7,0,3,0,1,8,0,0,0]]
     
    if(solve_sudoku(grid)):
        for i in range(9):
        for j in range(9):
            print arr[i][j],
        print ('')
    else:
        print "No solution exists"
