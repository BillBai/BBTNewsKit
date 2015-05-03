app_path = File.expand_path(File.dirname(__FILE__) + '/..')

worker_processes(ENV['RAILS_ENV'] == 'production' ? 3 : 1)

listen app_path + '/tmp/unicorn.sock', backlog: 64

listen "0.0.0.0:3031", :tcp_nopush => true

timeout 120

working_directory app_path

pid app_path + '/tmp/pids/unicorn.pid'

stderr_path app_path + '/log/unicorn.log'
stdout_path app_path + '/log/unicorn.log'

preload_app true

GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end