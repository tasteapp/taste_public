protos:
	@cd taste_protos && make
admin:
	@cd admin_tools && make
web:
	@cd admin_tools/taste_web && flutter run -d chrome --web-port 62098
web-dev:
	@cd admin_tools/taste_web && flutter run -d chrome --web-port 62098 -t lib/main_dev.dart
git-is-clean:
	git diff-index --quiet HEAD
version-bump: git-is-clean
	python version_bump.py
	git add taste/pubspec.yaml
	git commit -m 'version bump'
release: git-is-clean
	sh -e release.sh
new-version-release: git-is-clean version-bump release
cf-deploy-prod: git-is-clean
	sh -e cf-release.sh prod
cf-deploy-dev: git-is-clean
	sh -e cf-release.sh dev
cf-deploy: cf-deploy-dev cf-deploy-prod
rules-test:
	@cd rules && make test