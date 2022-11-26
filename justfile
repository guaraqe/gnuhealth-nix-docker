# Deployment

build-and-load-image:
	docker load < $(nix-build docker.nix)

tag-and-push-image:
	docker tag gnuhealth-nix registry.fly.io/$(cat secrets.json | jq -r .app_name)
	flyctl auth docker
	docker push registry.fly.io/$(cat secrets.json | jq -r .app_name)

deploy:
	flyctl deploy --app $(cat secrets.json | jq -r .app_name)

# Debugging

trytond-build:
	nix-build release.nix

start-image:
	docker run --network="host" gnuhealth-nix

inspect-image:
	docker exec -t -i $(docker ps -aq -f ancestor=gnuhealth-nix) /bin/bash

stop-image:
	docker stop $(docker ps -aq -f ancestor=gnuhealth-nix)
