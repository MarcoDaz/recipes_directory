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

  def find(id)
    sql = 'SELECT * FROM recipes WHERE id = $1;'
    param = [id]
    result = DatabaseConnection.exec_params(sql, param)[0]
    recipe = Recipe.new
    recipe.id = result['id']
    recipe.name = result['name']
    recipe.cooking_time = result['cooking_time']
    recipe.rating = result['rating']
    return recipe
  end
end