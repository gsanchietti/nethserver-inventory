# voips.rb

Facter.add('voips') do
  confine :osfamily => 'RedHat'
  setcode do
    agents = {}
    voips = []

    # detect nethserver-nethvoice version
    isVoice13 = Facter::Core::Execution.exec('rpm -qa | grep nethserver-nethvoice | grep 13')

    if isVoice13.length > 0
      # nethvoice 13
      tmp2 = Facter::Core::Execution.exec('asterisk -rx "database show" | grep \'^/registrar/contact/.*user_agent\' | sed \'s/^\/registrar\/contact\/\([0-9]*\);.*"user_agent":"\([^"]*\)".*/\1 \2/\' 2> /dev/null')
      if tmp2
        tmp2.split(/\n/).each do |agent|
          a = agent.split(' ')
          agents[a[0]] = a.drop(1).join(' ')
        end

        tmp = Facter::Core::Execution.exec('asterisk -rx "database show" | grep \'^/DEVICE/\' | sed \'s/^\/DEVICE\/\([0-9]*\)\/.*/\1/\' | sort -u 2> /dev/null')
        tmp.split(/\n/).each do |voip|
          voips.push({ "extension" => voip.strip, "useragent" => agents[voip] })
        end
      end
    else
      #nethvoice 11
      tmp = Facter::Core::Execution.exec('mysql asterisk -e \'SELECT DISTINCT id FROM sip WHERE id REGEXP "^[0-9]+$";\' 2> /dev/null')
      if tmp
        tmp.split(/\n/).each do |voip|
          if voip != 'id'
            tmp2 = Facter::Core::Execution.exec('asterisk -rx "sip show peer ' + voip + '" | grep Useragent | cut -d: -f2-')
            tmp2.split(/\n/).each do |agent|
              voips.push({ "extension" => voip.strip, "useragent" => agent.strip })
            end
          end
        end
      end
    end

    voips
  end
end