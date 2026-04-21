

estimate_id = ARGV[0]
estimate = Estimate.find(estimate_id)
lead = estimate.lead if lead.nil? && estimate.present?
project = lead.try(:project) || estimate.try(:project)
sales_rep = CoreModels::SalesUser.new(lead.rep) if lead&.rep
product_config = ProductConfig.find_by(name: "Solar")
allowed_territories = product_config.restricted_territory_ids
energy_bill = HomeEnergyBill.recent_for_home(lead&.home_id).first

allow_solar_comparison = project&.submitted? || sales_rep&.can_sell_product?("solar")
project_submitted = project&.submitted?
sales_rep_can_sell_solar = sales_rep&.can_sell_product?("solar")
solar_eligibility_enhancements = HomeTour::FeatureToggles.solar_eligibility_enhancements?(lead.home.territory.id)
allowed_territory = allowed_territories.include?(lead.home&.territory.id)
energy_bill_present = energy_bill.present?
lead_home_eligible = lead.home&.eligible_solar_project?

solar_comparison = if allow_solar_comparison
  if solar_eligibility_enhancements
    allowed_territory
  else
    energy_bill_present && lead.home&.eligible_solar_project?
  end
else
  false
end

puts "Allow solar comparison view? #{allow_solar_comparison} \n"
puts "Project submited: #{project_submitted}\n"
puts "Sales rep can sell solar: #{sales_rep_can_sell_solar}\n"
puts "-----------------------------------\n"

puts "Solar Eligibility Enhancements: #{solar_eligibility_enhancements}\n"
puts "Allowed territory? #{allowed_territory}\n"
puts "---------------- OR -------------------\n"
puts "Energy bill present? #{energy_bill_present}\n"
puts "Lead home eligible for solar project? #{lead_home_eligible}\n"
puts "-----------------------------------\n"
puts "Solar comparison: #{solar_comparison}"
