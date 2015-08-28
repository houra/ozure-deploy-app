require 'sinatra'

post '/' do

  deploy_timestamp = Time.now.strftime("%Y%m%d%H%M%S") 
  user_name = params['user_name']
  app_name = params['app_name']
  repository_url = params['repository_url']

  APPLICATION_DIR = "/var/www/#{user_name}/#{app_name}"

  # ソースのチェックアウト
  Dir.chdir "#{APPLICATION_DIR}/releases" do
    #`mkdir releases/#{deploy_timestamp}`
    `git clone #{repository_url} #{deploy_timestamp} `
     # confing_values = YAML.load_file('/Users/hirotoroura/dev/ozure-deploy-app/orz.conf')    
  end

  # シンボリックリンクの張り替え
  `unlink #{APPLICATION_DIR}/current`
  `ln -s #{APPLICATION_DIR}/releases/#{deploy_timestamp} #{APPLICATION_DIR}/current`

  # 古いディレクトリの削除 と シンボリックリンクの張り替え
  if Dir::entries("#{APPLICATION_DIR}/releases").count > 5
    delete_dir_name = Dir::entries("#{APPLICATION_DIR}/releases").sort[2]
    `rm -rf  #{APPLICATION_DIR}/releases/#{delete_dir_name}`
  end

end

