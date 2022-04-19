SENTRY_AUTH_TOKEN=161c3218c1604f2ba501fc51caeaa51e35d96108f36d42ec847758755a860a1f
SENTRY_ORG=ssi-hl
SENTRY_PROJECT=python-backend
VERSION=1.0.1

deploy: install create_release associate_commits run_django

install:
	pip install -r ./requirements.txt

create_release:
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) \
		set-commits $(VERSION) --auto

run_django:
	VERSION=$(VERSION) python manage.py runserver
