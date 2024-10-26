[![Build and Push Docker Image](https://github.com/zch2001/INFO-7500-backend/actions/workflows/makefile.yml/badge.svg)](https://github.com/zch2001/INFO-7500-backend/actions/workflows/makefile.yml)

# BitcoinExplorer-Backend
a backend application to provide metrics and data from database

### Build Process
`make docker-build VERSION={}`: build docker image

`source ~/.prod.env && make docker-run VERSION={}`: run image with env file

### Release Process:
#### Auto Release:
`make release VERSION={}`: this command will trigger github actions to build and tag with version and then push images to dockerhub
#### Mannual Release:
In order github action occurs any error, you can push image to dockerhub mannully

`make docker-push VERSION={}`: push local image to dockerhub
