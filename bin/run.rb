require_relative '../config/environment'

puts "hello world"

cli = CommandLineInterface.new
cli.greet
cli.menu
#cli.anything_else
cli.exit_app
