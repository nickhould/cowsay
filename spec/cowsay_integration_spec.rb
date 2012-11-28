require 'cowsay'

describe 'a cow object' do
  subject { Cowsay.new_cow }
  describe '#say' do
    it 'returns an ascii cow' do
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
      result = subject.say("Hello").strip
      result.should eq(expected)
    end
  end
end
