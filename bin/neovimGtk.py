#!/usr/bin/python

from neovim import stdio_session, Nvim

if __name__ == "__main__":
    print("Hello world")
    #session = stdio_session()
    #nvim = Nvim.from_session(session)
    
    ### Get the first buffer
    #buffer = nvim.buffers[0] 
    #buffer[0] = "First line"
    #buffer[1] = "Second line"
