admin_email = ENV.fetch("ADMIN_EMAIL", "admin@admin.com")
admin_pass  = ENV.fetch("ADMIN_PASSWORD", "admin")

admin = User.find_or_initialize_by(email_address: admin_email)
admin.username  ||= "admin"
admin.user_type = :admin
admin.password  = admin_pass
admin.password_confirmation = admin_pass

if admin.save
  puts "[seeds] Admin user ready: #{admin.email_address} (role: #{admin.user_type})"
else
  puts "[seeds] Failed to create admin: #{admin.errors.full_messages.to_sentence}"
end

# bin/rails db:setup (starting command)
# bin/rails server
