require 'rack/test'
require 'sinatra'
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
end
