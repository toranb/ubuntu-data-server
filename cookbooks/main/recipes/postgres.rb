node[:postgresql][:users].each do |user_data|

    pg_user user_data[:username] do
        user user_data
    end

end

node[:postgresql][:databases].each do |db|

    pg_database db[:name] do
        owner db[:owner]
    end

end
