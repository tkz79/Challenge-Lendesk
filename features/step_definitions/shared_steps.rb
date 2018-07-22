Then("a folder that is not readable") do
  setup_aruba
  Dir.mkdir('tmp/aruba/non_readable', 0300)
end

Then("a folder that is not writeable") do
  setup_aruba
  Dir.mkdir('tmp/aruba/non_writeable', 0500)
end
