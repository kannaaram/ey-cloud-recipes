#
# Cookbook:: pgweb
# Recipe:: default
#
# Copyright:: 2017, Wellthie, All Rights Reserved.

cookbook_file '/usr/bin/pgweb' do
  source 'pgweb'
  owner node[:owner_name]
  group node[:owner_name]
  mode  '0755'
  action :create
end

directory '/home/deploy/.pgweb/bookmarks' do
  recursive true
end

template '/home/deploy/.pgweb/bookmarks/wellthie.toml' do
  source 'bookmark.toml.erb'
  mode '0644'
end

execute 'start pgweb' do
  command 'nohup /engineyard/bin/pgweb  --bind=0.0.0.0 --listen=8089 --bookmarks-dir=/home/deploy/.pgweb/bookmarks/ --bookmark=wellthie --readonly -s > /dev/null 2>&1 &'
  user 'deploy'
end
