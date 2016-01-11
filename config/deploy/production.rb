set :stage, :production

server '188.166.190.93', user: 'deploy', roles: %w{web app}
