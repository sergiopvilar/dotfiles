u = User.find_by_username('sergio')
u.role = Role.superuser
u.assigned_customers = []
u.save!
