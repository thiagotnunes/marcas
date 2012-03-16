def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  system "rspec #{file}"
  puts
end

def run_feature(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  system "cucumber --guess -f progress #{file}"
end

watch("spec/.*/*_spec.rb") do |match|
  run_spec match[0]
end

watch("app/(.*/.*).rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end

watch("features/.*/*.feature") do |match|
  run_feature match[0]
end

watch("features/step_definitions/(.*)_steps.rb") do |match|
  run_feature %{features/#{match[1]}.feature}
end

