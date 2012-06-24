Fabricator(:user) do
  name Faker::Name.name
  email Faker::Internet.email
  password "p@ssw0RD"
end
