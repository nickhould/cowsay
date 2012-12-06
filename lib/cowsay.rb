module Cowsay
  def self.new_cow(*args)
    Cow.new(*args)
  end

  def self.cowfiles(options={})
    fs = options.fetch(:fs) { Pathname }
    paths = fs.glob("#{cowfile_dir}/*.cow")
    paths.map{ |path| path.basename(".cow") }.map(&:to_s).grep(/\A\w/).sort
  end

  def self.cowfile_dir
    (Pathname(__FILE__).dirname + "cows").expand_path
  end

  class Cow
    def initialize(options = {})
      @io = options.fetch(:io)          { IO }
      @cowfile = options.fetch(:cowfile) { 'default' }
    end

    def say(message)
      cowsay_path = File.join(File.dirname(__FILE__), '..', 'bin', 'cowsay')
      perl_path = '/usr/bin/perl'
      cows_path = File.join(File.dirname(__FILE__), 'cows')
      env = { 'COWPATH' => cows_path.to_s }
      args =  %W[-f #{@cowfile}]
      @io.popen([env, perl_path, cowsay_path.to_s, *args], 'r+') do |process|
        process.write(message)
        process.close_write
        process.read
      end
    end
  end
end
