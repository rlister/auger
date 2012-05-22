project "Front-End Nginx" do
  fqdns "www.brewster.com"
  hosts "prod-fe-r[01-02]"

  http 80 do
    get "/users/sign_in" do
      header "Location: www.brewster.com"

      test "Sign-in moved" do |response|
        response.body.match /301 Moved/
      end
 
      test "Sign-in 301" do |response|
        response.code == '301'
      end
    end

  end

  https 443 do
    insecure true

    get "/" do
      header "Location: www.brewster.com"

      test "SSL Status" do |r|
        r.code
      end
    end

  end

  ## example telnet request
  telnet 80 do
    timeout "3"
    binmode false
    
    cmd "HEAD / HTTP/1.1\n\n" do
      test "Telnet Port 80" do |r|
        r.match /Server: (nginx\/[\d\.]+)/
      end
    end
  end
end
