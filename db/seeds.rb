# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#ユーザーのテストデータ
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.introduction = "よろしく"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.introduction = "よろしくね"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.introduction = "よろしく！"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

tanaka = User.find_or_create_by!(email: "tanaka@example.com") do |user|
  user.name = "タナカ"
  user.introduction = "よろしくお願いします"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")
end

suzuki = User.find_or_create_by!(email: "suzuki@example.com") do |user|
  user.name = "スズキ"
  user.introduction = "健康第一"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")
end

satou = User.find_or_create_by!(email: "satou@example.com") do |user|
  user.name = "サトウ"
  user.introduction = "一期一会"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"), filename:"sample-user6.jpg")
end

yamamoto = User.find_or_create_by!(email: "yamamoto@example.com") do |user|
  user.name = "ヤマモト"
  user.introduction = "Hello"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user7.jpg"), filename:"sample-user7.jpg")
end

yoshida = User.find_or_create_by!(email: "yoshida@example.com") do |user|
  user.name = "ヨシダ"
  user.introduction = "写真好きです"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user8.jpg"), filename:"sample-user8.jpg")
end

kaneko = User.find_or_create_by!(email: "kaneko@example.com") do |user|
  user.name = "カネコ"
  user.introduction = "写真撮りたい"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user9.jpg"), filename:"sample-user9.jpg")
end

osada = User.find_or_create_by!(email: "osada@example.com") do |user|
  user.name = "オサダ"
  user.introduction = "カメラ好き"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user10.jpg"), filename:"sample-user10.jpg")
end

katori = User.find_or_create_by!(email: "katori@example.com") do |user|
  user.name = "カトリ"
  user.introduction = "カメラ友ほしい"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user11.jpg"), filename:"sample-user11.jpg")
end

kobayashi = User.find_or_create_by!(email: "kobayashi@example.com") do |user|
  user.name = "コバヤシ"
  user.introduction = "カメラ教えて"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user12.jpg"), filename:"sample-user12.jpg")
end

nakai = User.find_or_create_by!(email: "nakai@example.com") do |user|
  user.name = "ナカイ"
  user.introduction = "いい写真みたい"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user13.jpg"), filename:"sample-user13.jpg")
end

#投稿のテストデータ
PostImage.find_or_create_by!(body: "ピンクの花") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post_image.address = "埼玉県ふじみ野市福岡3-11-6"
  post_image.user = olivia
end

PostImage.find_or_create_by!(body: "四季彩の丘") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post_image.address = "北海道上川郡美瑛町新星第3"
  post_image.user = james
end

PostImage.find_or_create_by!(body: "芦ノ湖望むホテル") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post_image.address = "神奈川県足柄下郡箱根町元箱根桃源台160"
  post_image.user = lucas
end

PostImage.find_or_create_by!(body: "白華") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
  post_image.address = "東京都新宿区内藤町11"
  post_image.user = tanaka
end

PostImage.find_or_create_by!(body: "日本庭園") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg")
  post_image.address = "埼玉県入間市豊岡3-10"
  post_image.user = suzuki
end

PostImage.find_or_create_by!(body: "清水寺") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg")
  post_image.address = "京都府京都市東山区清水1-294"
  post_image.user = satou
end

PostImage.find_or_create_by!(body: "ディズニー！") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post7.jpg")
  post_image.address = "千葉県浦安市舞浜1-1"
  post_image.user = yamamoto
end

PostImage.find_or_create_by!(body: "渡月橋") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post8.jpg"), filename:"sample-post8.jpg")
  post_image.address = "京都府京都市右京区嵯峨天龍寺芒ノ馬場町1-5"
  post_image.user = yoshida
end

PostImage.find_or_create_by!(body: "スキー滑った") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post9.jpg"), filename:"sample-post9.jpg")
  post_image.address = "群馬県利根郡みなかみ町寺間479-139"
  post_image.user = kaneko
end

PostImage.find_or_create_by!(body: "桜良き") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post10.jpg"), filename:"sample-post10.jpg")
  post_image.address = "神奈川県鎌倉市雪ノ下2-1-31"
  post_image.user = osada
end

PostImage.find_or_create_by!(body: "江ノ島") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post11.jpg"), filename:"sample-post11.jpg")
  post_image.address = "神奈川県藤沢市江の島2-3-8"
  post_image.user = katori
end

PostImage.find_or_create_by!(body: "奥のおそ道") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post12.jpg"), filename:"sample-post12.jpg")
  post_image.address = "埼玉県戸田市重瀬745"
  post_image.user = kobayashi
end

PostImage.find_or_create_by!(body: "最高の写真撮れた") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post13.jpg"), filename:"sample-post13.jpg")
  post_image.address = "山梨県富士吉田市浅間2-4-1"
  post_image.user = kobayashi
end

Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password =ENV['ADMIN_PASSWORD']
end