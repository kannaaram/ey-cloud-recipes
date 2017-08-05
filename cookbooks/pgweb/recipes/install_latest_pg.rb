remote_file '/home/deploy/postgresql-9.6.3.tar.gz' do
  source 'https://ftp.postgresql.org/pub/source/v9.6.3/postgresql-9.6.3.tar.gz'
  action :create
end

execute 'untar the postgres 9.6.3 version' do
  cwd '/home/deploy/'
  command 'tar -zxvf postgresql-9.6.3.tar.gz'
end

execute 'Installation Step - configure postgresql' do
  cwd '/home/deploy/postgresql-9.6.3'
  command './configure --prefix /usr/local'
end

execute 'Installation Step - Make' do
  cwd '/home/deploy/postgresql-9.6.3'
  command 'make'
  command 'sudo make -C src/bin install'
  command 'sudo make -C src/include install'
  command 'sudo make -C src/interfaces install'
  command 'sudo make -C doc install'
  command 'sudo make install'
end
