# cloud9-dockerized
Provide a minimum image to run the Cloud9 IDE locally.

## credits
Heavily influenced by [kdelfour/cloud9-docker](https://registry.hub.docker.com/u/kdelfour/cloud9-docker/)

## usage
 1. build the docker image

    ```docker build -t="cloud9-dockerized:latest" github.com/maduck/cloud9-dockerized```
  
 3. run the newly created image
 
    ```docker run -d -p 8080:8080 cloud9-dockerized:latest```
    
 4. call ```http://localhost:8080``` in your browser
