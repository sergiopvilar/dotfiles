password = 'admin123'
u = User.find_by_username('sergio')
u.role = Role.superuser
u.password = password
u.password_confirmation = password
u.assigned_customers = []
u.save(validate: false)
