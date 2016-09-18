I'm not sure why I worked on this...

# Overview
This project can be used for downloading all users and their events and saving them into mongo.  It comes with an express server which can be used to view those users.


# Setup
1. `npm install`
2. `docker rm mongo`
3. `docker run --name mongo -p 27017:27017 mongo`

# To Run
1. `npm start`
