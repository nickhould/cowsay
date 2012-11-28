module Cowsay
  def self.new_cow(*args)
    Cow.new(*args)
  end

  class Cow

    def say(message)
      cowsay_path = File.join(File.dirname(__FILE__), '..', 'bin', 'cowsay')
      perl_path = '/usr/bin/perl'
      cows_path = File.join(File.dirname(__FILE__), 'cows')
      env = { 'COWPATH' => cows_path.to_s }
      IO.popen([env, perl_path, cowsay_path, message]) do |process|
        process.read
      end
    end
  end
end
