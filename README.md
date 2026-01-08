## Basic 3-tier App for Image

Docker images for a 3-tier architecture (FE, BE, and DB). The pushed images can be found below: 

Backend: https://hub.docker.com/r/serhatsdocker/be

Frontend: https://hub.docker.com/r/serhatsdocker/fe

Database: https://hub.docker.com/r/serhatsdocker/db

### Running Locally

To use these images locally, follow the instructions below. 

````
docker pull serhatsdocker/be:project
docker run serhatsdocker/be:project
````
Repeat the same steps for each image.

Alternatively, you can pre-pull all required images and then launch the entire stack by executing ````docker compose```` up within the project directory.



