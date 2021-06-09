type = ARGV.first || 'text'
multiple = ARGV[1]

customer = Customer.first
prop = Property.create(name: "Sample #{type} prop",
                       property_type: type,
                       multiple_values: multiple.present?,
                       applies_to_node: true, applies_to_node_group: true)

customer.node_groups.each do |group|
  group.node_properties << prop
  group.node_group_properties << prop
  group.save!
end

puts "Property #{prop.template_name} created!"
