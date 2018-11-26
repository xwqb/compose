path=$(cd ` dirname $0`;pwd)
docker build -t redis:5.0.2 $path
