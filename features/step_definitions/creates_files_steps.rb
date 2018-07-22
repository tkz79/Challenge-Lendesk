Then("a csv output file should exist") do
  expect(Dir.glob('tmp/aruba/imagegps_images_*.csv').any?).to be_truthy
end

Then("a html output file should exist") do
  expect(Dir.glob('tmp/aruba/imagegps_images_*.html').any?).to be_truthy
end
