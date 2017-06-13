#
# Cookbook:: pgweb
# Recipe:: default
#
# Copyright:: 2017, Wellthie, All Rights Reserved.

remote_file "/data/pgweb.zip" do
  source "https://github.com/sosedoff/pgweb/releases/download/v#{node[:pgweb][:version]}/pgweb_linux_amd64.zip"
end

execute 'extract the pgweb zip' do
  command 'cd /data; unzip -u pgweb.zip'
  cwd '/data/'
  only_if { File.exists?("/data/pgweb.zip") }
end

remote_file "/usr/bin/pgweb" do
  source "file:///data/pgweb_linux_amd64"
  owner 'root'
  group 'root'
  mode 0700
end

directory '/home/deploy/.pgweb/bookmarks' do
  recursive true
end

template '/home/deploy/.pgweb/bookmarks/wellthie.toml' do
  source 'bookmark.toml.erb'
  mode '0644'
end

# template '/etc/systemd/system/pgweb.service' do
#   source 'pgweb.service.erb'
# end

template '/etc/init.d/pgweb' do
  source 'pgweb.init.d.erb'
end

execute 'adding pgweb to service start' do
  command 'sudo rc-update add pgweb default'
end

execute 'start pgweb' do
  command 'sudo /etc/init.d/pgweb start'
end
# execute 'reload systemctl' do
#   command 'sudo systemctl daemon-reload && sudo systemctl enable pgweb.service'
# end
