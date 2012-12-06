require 'rack/test'
require 'sinatra'
require 'json'
require 'cow'

set :environment, :test

describe 'The Cow app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:response_body) {
    last_response.body.strip
  }

  it 'generates a basic cow' do
      expected = (<<-'RUBY').strip
 _______ 
< Hello >
 ------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
      RUBY
      get '/'
      result = response_body
      result.should eq(expected)
  end

  it 'generates a goodbye cow' do
    expected = (<<-'RUBY').strip
 ___________ 
< Good bye! >
 ----------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
    RUBY
    get '/', 'message' => 'Good bye!'
    result = response_body
    result.should eq(expected)
  end

  it 'accept a cowfile parameter' do
    expected = (<<-'END').strip
 _______ 
< Hello >
 ------- 
\                             .       .
 \                           / `.   .' " 
  \                  .---.  <    > <    >  .---.
   \                 |    \  \ - ~ ~ - /  /    |
         _____          ..-~             ~-..-~
        |     |   \~~~\.'                    `./~~~/
       ---------   \__/                        \__/
      .'  O    \     /               /       \  " 
     (_____,    `._.'               |         }  \/~~~/
      `----.          /       }     |        /    \__/
            `-.      |       /      |       /      `. ,~~|
                ~-.__|      /_ - ~ ^|      /- _      `..-'   
                     |     /        |     /     ~-.     `-. _  _  _
                     |_____|        |_____|         ~ - . _ _ _ _ _>    
END
    get '/', 'cowfile' => 'stegosaurus'
    result = response_body
    result.should eq(expected)

  end

  describe '/cowfile' do
    def do_request
      get '/cowfiles'
    end

    it "returns a list of available cowfiles is JSON" do
      do_request
      result = JSON.parse(response_body)
      result.should eq(%w[
        beavis.zen bong bud-frogs bunny cheese cower daemon default dragon
        dragon-and-cow elephant elephant-in-snake eyes flaming-sheep ghostbusters
        head-in hellokitty kiss kitty koala kosh luke-koala meow milk moofasa moose
        mutilated ren satanic sheep skeleton small sodomized stegosaurus stimpy
        supermilker surgery telebears three-eyes turkey turtle tux udder vader
        vader-koala www
        ])
    end

    it "returns cowfiles with a JSON content type" do
      do_request
      last_response.content_type.should match("application/json")
    end
  end
end
