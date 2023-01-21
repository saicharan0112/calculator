import math


def build_table_e(value):
    table = {}
    flag = 0
    count = 20
    for i in range(count):

        if not value < 2 and not flag:

            table[round(math.log(value), 4)] = value
            # print(value, table[value])
            value = int(math.sqrt(value))
            
        
        else:
            flag = 1

            if value == 1:
                value += 1
            
            x = round((value+1)/value, 4)
            table[round(math.log(x), 4)] = x
        
            # print(x, table[x])
            value = value * 2
    
    return table


def calculate_exp(x, table):
    k = list(table.keys())

    y = 1
   
    while (True):

        # keep resultant x always +ve 
        print(x, y)
        if x > 0:
            # find the largest possible k value so that x - k is always +ve
            for i in k:
                if i < x:
                    x1 = round(x - i, 5)
                    x = x1
                    break
                
                elif round(i, 3) == 0:
                    print("reached limit")
                    return y
                    

            # calculate the resultant y value = old y * new y from table
            y = y * table[i]

print("The final value is "+str(calculate_exp(4, build_table_e(64))))

