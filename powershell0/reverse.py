
socket = open("socket.ps1", "r")
string = ""

while 1: 
    char = socket.read(1)           
    if not char: 
        #socketBat.write('"\r\n')
        break
    if char != '\n':
        #socketBat.write(char)
        string += char

#print(string[::-1])
print(string)