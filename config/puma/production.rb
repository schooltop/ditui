dir = ENV['PWD']
sdir = ENV['PWD']

plugin :tmp_restart

port 3000
workers 4
threads 5, 64
environment 'production'
directory dir
daemonize true
prune_bundler true

bind "unix://#{File.expand_path('tmp/sockets/puma.sock', sdir)}"
pidfile "#{File.expand_path('tmp/pids/puma.pid', sdir)}"
state_path "#{File.expand_path('tmp/sockets/puma.state', sdir)}"
activate_control_app "unix://#{File.expand_path('tmp/sockets/pumactl.sock', sdir)}"
stdout_redirect "#{File.expand_path('log/puma.stdout.log', sdir)}",
                "#{File.expand_path('log/puma.stdout.log', sdir)}"

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

on_restart do
  puts '- * - On restart - * -'
  puts 'pidfile: '
  puts @options[:pidfile]
  puts 'binds: '
  puts @options[:binds]
  puts 'control_url: '
  puts @options[:control_url]
  puts '- * - * - * -'
end
