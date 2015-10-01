set :application, 'sample-app-html'

set :deploy_to, "/deploy/#{fetch :application}"

set :repo_url, 'git@github.com:ohiro/ozure-deploy-app.git'

set :keep_releases, 5

set :pty, true

