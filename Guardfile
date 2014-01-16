# guard :rspec, all_after_pass: true do
#   watch(%r{^spec/.+_spec\.rb$})
#   watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
#   watch('spec/spec_helper.rb')  { 'spec' }

#   watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
#   watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
#   watch(%r{^app/(.*)(\.erb|\.haml)$})                 { 'spec/features' }
#   watch(%r{^spec/factories/(.+)\.rb$})                { 'spec/factories_spec.rb' }
#   watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
#   watch('config/routes.rb')                           { 'spec/routing' }
#   watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
# end

# guard :rubocop, all_after_pass: true, cli: ['--rails', '--auto-correct'] do
#   watch(%r{.+\.rb$})
#   watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
# end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/spec_helper\.rb$})                   { |m| 'spec' }
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  do |m|
    %W(spec/routing/#{m[1]}_routing_spec.rb spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb spec/requests/#{m[1]}_spec.rb)
  end
end
