include_recipe "nginx"

app_name = "#{node['app']['name']}"

template "/etc/nginx/sites-available/#{node['app']['name']}.conf" do
  source "nginx_virtual_host.conf.erb"
  action :create
end

template "/etc/nginx/sites-available/dev-tools.conf" do
  source "nginx_virtual_host_dev_tools.conf.erb"
  action :create
end

nginx_site "#{node['app']['name']}.conf" do
  enable true
  notifies :restart, :service => 'nginx'
end

nginx_site "dev-tools.conf" do
  enable true
  notifies :restart, :service => 'nginx'
end

# nginx_site "#{node['app']['name']}" do
#   root "/var/www/#{node['app']['name']}"
#   index 'index.php index.html index.htm'
#   slashlocation 'try_files $uri $uri/ /index.php?$query_string'
#   phpfpm true
#   action [:create, :enable]
# end

# Disable default vhost config
nginx_site "default" do
  enable false
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end