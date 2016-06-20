# flashstart.rb

Facter.add('flashstart') do
  setcode do
    file = File.open("/var/log/squid/access.log", 'r')
    ips = Array.new
    while !file.eof?
      line = file.readline
      fields = line.strip.split("\s")
      if (fields[3] =~ /TCP_HIT/)
        t = Time.at(fields[0].to_i)
        now = Time.now
        if (now.mday == t.mday && now.month == t.month && now.year == t.year)
          ips.push(fields[2])
        end
      end
    end
    ips.uniq.length 
  end
end
