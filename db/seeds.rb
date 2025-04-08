# Create regular users
[
  { email: 'user1@example.com', password: 'PassUser01', full_name: 'Juan Perez', role: :user },
  { email: 'user2@example.com', password: 'PassUser02', full_name: 'María García', role: :user },
  { email: 'user3@example.com', password: 'PassUser03', full_name: 'Carlos López', role: :user },
  { email: 'user4@example.com', password: 'PassUser04', full_name: 'Ana Martínez', role: :user },
  { email: 'user5@example.com', password: 'PassUser05', full_name: 'Pedro Rodríguez', role: :user }
].each do |user_data|
  User.create!(user_data)
end

# Create admin user
User.create!(
  email: 'admin@example.com',
  password: 'AdminPass123',
  full_name: 'Administrator',
  role: :admin
)
