require 'recipe_repository'

RSpec.describe RecipeRepository do
    def reset_recipes_table
        seed_sql = File.read('spec/seeds_recipes.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
        connection.exec(seed_sql)
    end
    
    before(:each) do 
        reset_recipes_table
    end
  
    describe '#all' do

    it 'displays all recipes' do
      repo = RecipeRepository.new
      recipes = repo.all

      expect(recipes.length).to eq 2

      expect(recipes[0].id).to eq '1'
      expect(recipes[0].name).to eq 'Lasagna'
      expect(recipes[0].cooking_time).to eq '45'
      expect(recipes[0].rating).to eq '4'

      expect(recipes[1].id).to eq '2'
      expect(recipes[1].name).to eq 'Spaghetti Carbonara'
      expect(recipes[1].cooking_time).to eq '30'
      expect(recipes[1].rating).to eq '3'
    end
  end

  describe '#find' do
    it 'finds a specific recipe' do
        repo = RecipeRepository.new

        recipe = repo.find(1)

        expect(recipe.id).to eq '1'
        expect(recipe.name).to eq  'Lasagna'
        expect(recipe.cooking_time).to eq '45'
        expect(recipe.rating).to eq '4'
    end
  end
end