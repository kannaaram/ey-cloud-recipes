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

template '/engineyard/bin/pgweb' do
  source 'pgweb.init.d.erb'
  owner node[:owner_name]
  group node[:owner_name]
  mode 0755
end

directory '/home/deploy/.pgweb/bookmarks' do
  recursive true
end

template '/home/deploy/.pgweb/bookmarks/wellthie.toml' do
  source 'bookmark.toml.erb'
  mode '0644'
end

template "/etc/monit.d/pgweb.monitrc" do
  source "pgweb.monitrc.erb"
  owner node[:owner_name]
  group node[:owner_name]
  mode 0644
  variables({
    :user => node[:owner_name],
    :group => node[:owner_name]
  })
end

execute "monit-reload" do
  command "monit quit && telinit q"
end

execute "start-pgweb" do
  command "sleep 3 && monit start pgweb"
end
