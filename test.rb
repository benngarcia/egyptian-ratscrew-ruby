require 'pry'

if __FILE__ == $0
  Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| load file }

end