name              "app"
maintainer        "scourgen"
maintainer_email  "scourgen@gmail.com"
version           "1.0.0"


depends "apt"
depends "nginx"
depends "php"
depends "mysql"

%w{ debian ubuntu }.each do |os|
  supports os
end



recipe "app", "my app"