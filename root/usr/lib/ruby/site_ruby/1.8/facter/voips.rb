# voips.rb

Facter.add('voips') do
  confine :osfamily => 'RedHat'
  setcode do
    tmp = Facter::Core::Execution.exec('mysql asterisk -e \'SELECT DISTINCT id FROM sip WHERE id REGEXP "^[0-9]+$";\'')
    voips = []
    tmp.split(/\n/).each do |voip|
      if voip != 'id'
        tmp2 = Facter::Core::Execution.exec('asterisk -rx "sip show peer ' + voip + '" | grep Useragent | cut -d: -f2-')
        tmp2.split(/\n/).each do |agent|
          voips.push({ "extension" => voip.strip, "useragent" => agent.strip })
        end
      end
    end
    voips
  end
end