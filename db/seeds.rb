# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ['Action', 'Comedy', 'Drama', 'Horror'].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
names = ['Alfonso', 'Sanda Rowe', 'Santiago Romaguera', 'Ignacio Glover', 'Garnett Yundt', 'Dorine Fisher', 'Mrs. Vertie Wehner',
         'Prof. Casey Johnson', 'Rocky Stark', 'Sen. Norbert Beier', 'Robby Stoltenberg', 'Cindy Champlin', 'Beverly Mante', 'Heath Crooks', 'Russell Gerlach', 'Amalia Jacobs PhD', 'Refugio Schiller', 'Sol Cremin', 'Lanny Hackett', 'Casimira Kessler', 'Marta Cremin', 'Nan West', 'Tien Mills', 'Humberto Kling', 'Deon Bruen', 'Larhonda Miller', 'Cecil King', 'Brendan Corwin', 'Sen. Josh Fahey', 'Carol Hackett', 'Chanelle Johnston', 'Virgie Fay', 'Raul Harber', 'Lottie Shanahan', 'Jacalyn Cruickshank', 'Rory Beahan', 'Krystle Sipes', "Ina O'Hara DVM", 'Prof. Jarrett Predovic', 'Jerrell Kutch III', 'Dede Marvin', 'Mario Swift', 'Harland Harris', 'Sung Altenwerth', 'Ms. Carol Lind', 'Linnie Kunde', 'Dani Schultz', 'Alejandrina Hansen LLD', 'Robert Oberbrunner', 'Damon Crona', 'Louetta Boehm', 'Leslie Reichel', 'Jacques Cremin', 'Patrick Weber VM', 'Sang Cassin', 'Felicidad Quitzon', 'Pres. Malik Olson', 'Elin Reynolds', 'Beau Parker', 'Rosario Herzog', 'Charley Stark', 'Gov. Wilfredo Gulgowski', 'Clark Stracke', 'Cristine Welch', 'The Hon. Alexis Littel', 'Yee Welch', 'Jerrod Kshlerin', 'Miguel Johns II', 'Justina Littel', 'Sen. Josephina Haley', 'Brett Kshlerin', 'Yanira Weissnat DO', 'Delinda Beier', 'Mrs. Cornelius Stamm', 'Vito Kuphal', 'Jacinda Davis', 'My Ondricka JD', 'Rev. Chanel Stokes', 'Norris Paucek DDS', 'Tristan Mueller', 'Marcelo Emard VM', 'Msgr. Renaldo Maggio', 'Berenice Ward', 'Shela Waelchi', 'Dr. Renato Berge', 'Carey Halvorson', 'Janis Funk', 'Wiley Cruickshank MD', 'Rikki Pfannerstill', 'Loriann Stanton', 'Maryetta Fritsch', 'Virgil Ullrich', 'Jerome Mertz', 'Werner Mann', 'Bryan Kutch Esq.', 'Zachery Lockman', 'Kendal Farrell', 'Vern Crooks', 'Hyon Hagenes', 'Donnie Hermann', 'Max Gusikowski']
users = []

p 'Creating users...'
names.each do |name|
  email = "#{name.gsub(/[^\d\w]+/, '_').downcase}@email.com"
  user = User.find_or_create_by(name:, email:)
  user.update password: 'password' if user.new_record?
  Organization.create(members: [user]) if user.organizations.blank?
  users.push user
end

p 'Creating listings...'
users.each do |user|
  next unless user.listings.empty?

  number_of_products = (user.name.length % 3) + 1
  number_of_products.times do
    blob_path = Rails.root.join('test', 'fixtures', 'files', "test-image-#{rand(1..9)}.jpg")
    cover_photo_blob = ActiveStorage::Blob.create_and_upload!(io: StringIO.new(File.read(blob_path)),
                                                              filename: 'photo.jpg')
    Listing.create(
      creator: user,
      organization: user.organizations.first,
      title: Faker::Commerce.product_name,
      price: Faker::Commerce.price.floor,
      condition: Listing.conditions.values.sample,
      tags: Faker::Commerce.send(:categories, 4),
      cover_photo: cover_photo_blob,
      address_attributes: {
        line_1: Faker::Address.building_number,
        line_2: Faker::Address.street_address,
        city: Faker::Address.city,
        country: 'GB',
        postcode: Faker::Address.postcode
      }
    )
  end
end
