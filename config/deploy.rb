set :application, 'ozure-deploy-app'

set :deploy_to, "/deploy/#{fetch :application}"

set :repo_url, 'git@github.com:ohiro/ozure-deploy-app.git'

set :keep_releases, 5

set :pty, true

task :gem_install do  
  #ここにサーバ上で実行するコマンド
  on roles(:app) do
    execute "cd /deploy/#{fetch :application}/current; bundle install"
    # p "ばんどる"
  end
end

after 'deploy:finished', 'gem_install'

