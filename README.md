This repo is part of the final exam for csc424, to display knowledge of docker, docker-compose, nginx, and a CI/CD pipeline using github actions.

# DevOps Setup

### how to run
To run the stack locally, just clone the repo, and run docker compose up --build -d in the same directory as the docker-compose.yml file

### ports
nginx automatically maps port 80 (the default port for http) to the frontend container at http://frontend:80/ 

and maps http://localhost/api/ to the backend container at http://backend:8080/api/

see nginx/nginx.conf for full configuration

### testing
to test the frontend, just open your browser and type in localhost

to test the backend, open your terminal and type curl https://localhost/api/ping

### service description
Frontend container is a React + Vite frontend app that is build with npm and then served by nginx

Backend container is a .NET application built with the .NET SDK and then packaged with the runtime

nginx container is a reverse proxy to the 2 applications

### CI/CD pipeline:
When a push is made to main, 

github actions triggers a job that pushes the 3 docker images to a dockerhub account (configured via github action secrets)

then, when that finishes, a second job will SSH into a server (ip, hostname, and ssh key are configured via github action secrets) where it will deploy all 3 of the images using docker compose

right now, the docker-compose.yml used in the 2nd job is hard coded into the workflow file, but it can easily be added to the github repo as a seperate file to be pulled by the QA server seperatly

sshing into a different server from github actions is already not the best solution, since you can just set up your QA server as a runner, and avoid the middle man
