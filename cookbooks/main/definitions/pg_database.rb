define :pg_database do
  owner = params[:owner]
  name = params[:name]

  bash "create_pg_database_#{name}" do
    user 'root'
    code "sudo -u postgres createdb -O #{owner} #{name}"
    not_if "sudo -u postgres psql -l | grep #{name}"
  end

end
