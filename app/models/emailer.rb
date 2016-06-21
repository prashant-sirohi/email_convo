class Emailer < ActiveRecord::Base
	attr_accessor :mail, :mail_to, :sub
end
