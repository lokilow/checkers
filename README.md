# Tic Tac Toe

All rendering done server side

Inspired by [Chris McCord's keynote at
ElixirConf2018](https://www.youtube.com/watch?v=Z2DU0qLfPIY)

I don't expect the performance to be nearly as good as the coming LiveView for Phoenix

Some of the math behind the model is attributed to the [MathWorks aritcle on tic tac toe
and magic
squares](https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/moler/exm/chapters/tictactoe.pdf)

## To Run
If you have Docker installed, you can use the deply script.
This will take a while the first time you build the image.
```
git clone https://github.com/lokilow/tic-tac-toe.git
cd tic-tac-toe 
sh deploy.sh
```

Otherwise, if you already have racket installed, run

```
git clone https://github.com/lokilow/tic-tac-toe.git
cd tic-tac-toe 
racket app.rkt
```
