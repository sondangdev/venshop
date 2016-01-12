set :stage, :production

server '128.199.216.19', user: 'deploy', roles: %w{web app}
