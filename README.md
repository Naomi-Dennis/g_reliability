# MindTheGapp


## Testing 
Testing framework is `ExUnit`. Use `mix test` to run tests. 

## Start Local Server:

	- Build Docker image `docker build . --tag mind_the_gapp`
	- Run Docker image `docker run -e GAPP_DB=$GAPP_DB,GAPP_PASS=$GAPP_PASS -p 4000:4000 mind_the_gapp`
	- Go to `localhost:4000` in browser

## Deploy to Elastic Beanstalk

	- Run `eb deploy --envvars GAPP_DB=$GAPP_DB GAPP_PASS=$GAPP_PASS`

