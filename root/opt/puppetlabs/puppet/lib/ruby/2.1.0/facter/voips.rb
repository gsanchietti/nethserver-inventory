# voips.rb

Facter.add('voips') do
  confine :osfamily => 'RedHat'
  setcode do
    tmp2 = Facter::Core::Execution.exec('asterisk -rx "database show" | grep \'^/registrar/contact/.*user_agent\' | sed \'s/^\/registrar\/contact\/\([0-9]*\);.*"user_agent":"\([^"]*\)".*/\1 \2/\'')
    agents = {}
    tmp2.split(/\n/).each do |agent|
      a = agent.split(' ')
      agents[a[0]] = a.drop(1).join(' ')
    end

    tmp = Facter::Core::Execution.exec('asterisk -rx "database show" | grep \'^/DEVICE/\' | sed \'s/^\/DEVICE\/\([0-9]*\)\/.*/\1/\' | sort -u')
    voips = []
    tmp.split(/\n/).each do |voip|
      voips.push({ "extension" => voip.strip, "useragent" => agents[voip] })
    end
    voips
  end
end