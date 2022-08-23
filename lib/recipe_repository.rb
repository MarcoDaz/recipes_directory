require_relative 'recipe'

class RecipeRepository
  def all
    sql = 'SELECT * FROM recipes;'
    result = DatabaseConnection.exec_params(sql, [])
    recipes = []
    result.each do |record|
      recipe = Recipe.new

      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']

      recipes << recipe
      
    end

    return recipes
  end
end