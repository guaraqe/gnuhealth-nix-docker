build-trytond:
	nix-build release.nix

build-and-load-image:
	docker load < $(nix-build docker.nix)

tag-and-push-image APP:
	docker tag gnuhealth-nix registry.fly.io/{{APP}}
	flyctl auth docker
	docker push registry.fly.io/{{APP}}

deploy APP:
	flyctl deploy --app {{APP}}
