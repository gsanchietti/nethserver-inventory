# products.rb

require 'json'

Facter.add('nh-products') do
    setcode do
        installed_groups = []
        installed_categories = {}
        tmp = Facter::Core::Execution.exec('/usr/bin/sudo /usr/libexec/nethserver/pkginfo compsdump')
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
        installed_categories
    end
end
