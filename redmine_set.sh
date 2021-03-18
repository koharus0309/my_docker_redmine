#!/bin/bash

docker exec -u root my-pm-redmine sh -c "git clone https://github.com/farend/scm-creator.git /usr/src/redmine/plugins/redmine_scm"
docker exec -u root my-pm-redmine sh -c "chown redmine:redmine -R /usr/src/redmine/plugins/redmine_scm"
docker exec -u root docker_redmine-container_1 sh -c "git clone https://github.com/koppen/redmine_github_hook.git /usr/src/redmine/plugins/redmine_github_hook"
docker exec -u root docker_redmine-container_1 sh -c "chown redmine:redmine -R /usr/src/redmine/plugins/redmine_github_hook"

docker exec -u redmine my-pm-redmine bundle install --jobs=4 --without development test
docker exec -u root my-pm-redmine bundle exec rake redmine:plugins:migrate RAILS_ENV=production
docker exec my-pm-redmine passenger-config restart-app /usr/src/redmine
