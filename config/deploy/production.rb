server '13.115.55.66', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/qz/.ssh/id_rsa'