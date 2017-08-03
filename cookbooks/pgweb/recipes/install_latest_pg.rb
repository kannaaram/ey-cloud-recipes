remote_file '/home/deploy/postgresql-9.6.run' do
  source 'https://get.enterprisedb.com/postgresql/postgresql-9.6.3-2-linux-x64.run'
  mode '0755'
  action :create
  owner 'root'
  group 'root'
end

execute "install pg 9.6" do
  command '/home/deploy/postgresql-9.6.run --mode unattended'
  not_if { FileTest.directory?("/opt/PostgreSQL/9.6") }
end
