code = ARGV.first
customer = Customer.find_by(code: code)
puts "Importing nodes for #{customer.code}..."
customer.nodes.import
