include_recipe "apt"


node['packages'].each do |a_package|
  package a_package
end