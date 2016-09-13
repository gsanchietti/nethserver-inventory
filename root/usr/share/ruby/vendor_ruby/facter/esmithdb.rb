# esmithdb.rb
require 'rubygems'
require 'json'

Facter.add('esmithdb') do
    setcode do
        dbs = {}
        Dir.entries("/var/lib/nethserver/db").each do |db|
            if db == '.' or db == '..'
                next
            end
            tmp = Facter::Core::Execution.exec("/sbin/e-smith/db #{db} printjson")
            dbs[db] = JSON.parse(tmp)
        end
        dbs
    end
end
