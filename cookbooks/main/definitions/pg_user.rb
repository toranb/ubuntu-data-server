define :pg_user do
  user = params[:user]
  username = params[:name]
  password = user[:password]

  create_user_command = begin
    if user['superuser']
      "sudo -u postgres createuser -s #{username};"
    elsif user['create_database']
      "sudo -u postgres createuser -S -d -R #{username};"
    else
      "sudo -u postgres createuser -S -D -R #{username};"
    end
  end

  set_user_password = begin
    "sudo -u postgres psql -c \"ALTER USER #{username} " +
    "WITH PASSWORD '#{password}';\""
  end

  bash "create_pg_user_#{username}" do
    user 'root'
    code "#{create_user_command} #{set_user_password}"
    not_if "sudo -u postgres psql -c \"\\du\" | grep #{username}"
  end

end
