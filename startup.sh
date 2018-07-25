echo "-- Stopping all containers"
docker kill $(docker ps -q)

echo "-- Removing old images"
docker system prune -f

echo "-- Creating new jupyter script"
rm jupyter.sh
#echo "jupyter notebook `basename $PWD`.ipynb --ip 0.0.0.0 --no-browser --allow-root" > jupyter.sh
echo "jupyter notebook . --ip 0.0.0.0 --no-browser --allow-root" > jupyter.sh
chmod 777 jupyter.sh

echo "-- Building new image"
imagename=`basename $PWD`
imagename+="-app"

docker build -t $imagename .

echo "-- running container"
docker run -it -p 8888:8888 -v $PWD:/opt/app $imagename
