require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

DatabaseConnection.connect('recipes_directory_test')

repo = RecipeRepository.new

repo.all.each do |recipe|
    puts "#{recipe.id} - #{recipe.name} - #{recipe.cooking_time} minutes - #{recipe.rating}/5"
end