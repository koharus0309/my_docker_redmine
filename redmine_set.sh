#!/bin/bash

docker exec -u root redmine_container sh -c "git clone https://github.com/farend/scm-creator.git /usr/src/redmine/plugins/redmine_scm"
docker exec -u root redmine_container sh -c "chown redmine:redmine -R /usr/src/redmine/plugins/redmine_scm"
docker exec -u redmine redmine_container bundle install --jobs=4 --without development test
docker exec -u root  redmine_container bundle exec rake redmine:plugins:migrate RAILS_ENV=production
docker exec redmine_container passenger-config restart-app /usr/src/redmine
