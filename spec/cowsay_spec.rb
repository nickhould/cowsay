require 'pathname'
require 'cowsay'

module Cowsay
	describe '.cowfiles' do
		let(:filesystem) { double("filesystem", :glob => cowfile_list) }
		let(:cowfile_list) { 
			%w[cow1.cow a/b/cow2.cow ~cowbak.cow].map{|path|
				Pathname(path)
			}
		}

		it "should list available cow files" do
			result = Cowsay.cowfiles(:fs => filesystem)
			result.should eq(%w[cow1 cow2])
		end

		it "asks the filesystem for the correct glob pattern" do
			cowfile_path = (Pathname(__FILE__).dirname + "../lib/cows").expand_path
			filesystem.should_receive(:glob).with("#{cowfile_path}/*.cow")
			Cowsay.cowfiles(:fs => filesystem)
		end
	end



	describe Cowsay::Cow do
		context 'given a cowfile' do
			subject { Cow.new(:cowfile => 'MYCOW', io: io) }
			let(:io) { double =("IO") }

			it "sends the appropriate cowfile flags to the item" do
				io.should_receive(:popen) do |command|
					command.each_cons(2).should include(%w[-f MYCOW])
					"THE_COW"
				end
				subject.say("Hello")
			end
		end	
	end
end