# products.rb

require 'json'

Facter.add('nh-products') do
    setcode do
        installed_groups = []
        installed_categories = {}
        tmp = Facter::Core::Execution.exec('/usr/libexec/nethserver/pkginfo compsdump')
        begin
            products = JSON.parse(tmp)
            products['groups'].each do |_g|
                installed_groups.push(_g['id']) if _g['installed'] == true
            end

            products['categories'].each do |_c|
                # check if intersection is empty
                if (_c['groups'] & installed_groups).any?
                    next if _c['id'] == 'BASENG0001'
                    installed_categories[_c['id']] = _c['name']
                end
            end
            target = File.open('/var/cache/nethserver-inventory', 'w')
            target.write(installed_categories.to_json)
        rescue JSON::ParserError => e
            if File.exist?('/var/cache/nethserver-inventory')
                tmp = File.read('/var/cache/nethserver-inventory')
                installed_categories = JSON.parse(tmp.to_s)
            else
                installed_categories = {}
            end
        end
        installed_categories
    end
end
