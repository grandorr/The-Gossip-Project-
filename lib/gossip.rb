class Gossip 
	require 'csv'
	require 'pry'
	attr_reader :author, :content

	def initialize(author, content)
		@content = content
		@author = author
	end

	def save 
		require "csv"
		CSV.open("db/gossip.csv", "ab") do |csv|
  		csv << [@author, @content]
		end
	end

  def self.all
  all_gossips = []
  CSV.read("./db/gossip.csv").each do |csv_line|
    all_gossips << Gossip.new(csv_line[0], csv_line[1])
  end
  return all_gossips
	end

	def self.find(number)
		n = 1
		gossips = [] 
		CSV.read("./db/gossip.csv").each do |csv_line|
			if n == number
				gossips << Gossip.new(csv_line[0], csv_line[1])
			return gossips
			end
			n += 1 
		end
	end


	def self.update(id,author,content)
		gossips = [] 
		CSV.read("./db/gossip.csv").each_with_index do |row, index|
			if id.to_i == (index +1 )
				gossips << [author, content]
			else 
				gossips << [row[0], row[1]]
			end
		end

		CSV.open("./db/gossip.csv", "w") do |csv| 
			gossips.each do |row|
				csv << row
			end
		end
	end
end










