# users.rb

require 'json'

Facter.add('users') do
    confine :osfamily => 'RedHat'
    setcode do
        users = []
        tmp = Facter::Core::Execution.exec('/sbin/e-smith/db accounts printjson')
        begin
            users_info = JSON.parse(tmp)
            users_info.each do |user|
                if user['type'] == "user"
                    full_name = ""
                    full_name = user['props']['FirstName'] + " " + user['props']['LastName']
                    users.push({ "username" => user['name'], "name" => full_name })
                end
            end

        rescue JSON::ParserError => e
            users = []
        end
        users
    end
end

