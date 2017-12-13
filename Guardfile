guard :minitest do
  watch(%r{^test\/(.*)\/?(.*)_test\.rb$}) { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^lib\/(ufebs)\.rb|ufebs\/(.+)\.rb$})  do |m|
    pattern = "test/ufebs_test.rb" if m[1]
    pattern = "test/#{m[2]}_test.rb" if m[2]
    pattern
  end
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
