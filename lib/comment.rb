class Commentaire
require 'csv'
attr_reader :id, :comment

	def initialize(comment,id)
		@id = id
		@comment = comment 
	end

	def save 

		CSV.open("db/comment.csv", "ab") do |csv|
  		csv << [@id, @comment]
		end
	end
	def self.all(id) 
		all_comment = []
		CSV.read("./db/comment.csv").each do |csv_line|
		if csv_line[0] == id
    all_comment << Commentaire.new(csv_line[0], csv_line[1])
  	end
 
	end
	  return all_comment
	end
end