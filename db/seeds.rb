i = 1
a = 1
199.times do
Image.create!(
file_id: ['1687654e4eb2d536fe0d59de264c6244b92ff03da25e32f38eb94e26e539','04c86fb9b07208fcea64889aea5059d7c4939b5a3f5ba5edf7f00f313b9f','15a33afca32c3f5b59b8035b17c324f198a76919bb09105dc3035a458a4d','f8ed69e4e3bcce539e368bf9509f1389c4afc0d3d5af6e37ada037a50c95'].sample,
board_id: a,
)

a += 1
end

i = 1
150.times do
Image.create!(
file_id: ['1687654e4eb2d536fe0d59de264c6244b92ff03da25e32f38eb94e26e539','04c86fb9b07208fcea64889aea5059d7c4939b5a3f5ba5edf7f00f313b9f','15a33afca32c3f5b59b8035b17c324f198a76919bb09105dc3035a458a4d','f8ed69e4e3bcce539e368bf9509f1389c4afc0d3d5af6e37ada037a50c95'].sample,
accessory_id: i
)
i += 1

end




images = Image.all
