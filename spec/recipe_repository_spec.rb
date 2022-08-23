require 'recipe_repository'

RSoec.describe RecipeRepository do
    describe '#all' do
        it 'displays all recipes' do
            repo = RecipeRepository.new
            recipes = repo.all

            expect(recipes.length).to eq 2

            expect(recipes[0].id).to eq 1
            expect(recipes[0].name).to eq 'Lasagna'
            expect(recipes[0].cooking_time).to eq 5
            expect(recipes[0].rating).to eq 4

            expect(recipes[1].id).to eq 2
            expect(recipes[1].name).to eq 'Spaghetti Carbonara'
            expect(recipes[1].cooking_time).to eq 30
            expect(recipes[1].rating).to eq 3
        end
    end
end