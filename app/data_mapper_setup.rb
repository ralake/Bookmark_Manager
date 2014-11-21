env = ENV["RACK_ENV"] || "development"

database_url = if env == 'production'
    ENV['DATABASE_URL']
  else
    ENV['DATABASE_URL'] + "_#{env}"
  end

DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://localhost/bookmark_manager_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!

