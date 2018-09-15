docker build . -t tic-tac-toe
docker run -d -p 8080:8080 tic-tac-toe
gzip /static/*
