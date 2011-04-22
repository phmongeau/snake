MXMLC = fcsh-wrap
FLIXEL = /Users/philippemongeau/Documents/Flex/Library/flixelDev
SRC = *.as 
MAIN = Snake.as
SWF = Game.swf

$(SWF) : $(SRC)
	$(MXMLC) $(MAIN)  -o $(SWF) -static-link-runtime-shared-libraries=true --source-path=$(FLIXEL)
