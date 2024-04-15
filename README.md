# **Conway's Game of Life**

Conway's Game of Life is a cellular automaton devised by mathematician John Horton Conway. 

It's a zero-player game, meaning its evolution is determined by its initial state, requiring no further input from human players. 

Our game takes place on a 16 by 16 grid of cells, which can be alive or dead. Cells evolve through generations based on simple rules regarding the number of live neighbors. This setup leads to complex behaviors and patterns. 

![Game of Life GIF](README.md_supplements/game_of_life_gif.gif)

## **_Rules_ to Life**:

1. Any live cell with two or three live neighbors lives on to the next generation.

2. Any live cell with fewer than two live neighbors dies, as if by underpopulation.

3. Any live cell with more than three live neighbors dies, as if by overpopulation.

4. Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

# Asher Holtham's Nexys4 board Verilog Implementation Project Details

## When alive, this is what a cell in our game will look like:
![Cell Image](README.md_supplements/node.jpg)

- _Portrait photo of USC's Prof. Gandhi Puvvada_
## EE354 State Diagram:

![state machine diagram](README.md_supplements/Game_of_Life_Nexys4_State_Diagram.jpg)
