if File.exist?("/etc/php5/mods-available/redis.ini")
  link "/etc/php5/fpm/conf.d/99-redis.ini" do
    link_type :symbolic
    to "/etc/php5/mods-available/redis.ini"
    action :create
  end

  link "/etc/php5/cli/conf.d/99-redis.ini" do
    link_type :symbolic
    to "/etc/php5/mods-available/redis.ini"
    action :create
  end
end