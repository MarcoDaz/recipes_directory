<!--
1. Design and create the table if needed.
2. Create test SQL seeds.
3. Define the Model and Repository class names.
4. Implement the Model class.
5. Design the Repository class interface.
6. Write test examples.
7. Test-driven and implement the Repository class behaviour.
-->

# Recipes Model and Repository Classes Design Recipe

## 1 .Design and create the Table

If the table is already created in the database, you can skip this step.

```
Table: recipes

Columns:
id | name | cooking_time | rating
```

## 2. Create Test SQL Seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run so we ca start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes
  (name, cooking_time, rating)
  VALUES ('Lasagna', 45, 4);

INSERT INTO recipes
  (name, cooking_time, rating)
  VALUES ('Spagetti Carbonara', 30, 3);
```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 recipes_directory < seeds_recipes.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: recipes


class Recipe
end

class RecipeRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cooking_time, :rating
end

```
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: recipe
# Repository class
# (in lib/recipe_repository.rb)

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM recipes;

    # Returns an array of Recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM recipes WHERE id = $1;

    # Returns a single Recipe object.
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all recipes

repo = RecipeRepository.new

recipes = repo.all

recipes.length # =>  2

recipes[0].id # =>  1
recipes[0].name # =>  'Lasagna'
recipes[0].cooking_time # => 45
recipes[0].rating # =>  4

recipes[1].id # =>  2
recipes[1].name # =>  'Spaghetti Carbonara'
recipes[1].cooking_time # =>  30
recipes[1].rating # => 3

# 2
# Get a single recipe

repo = RecipeRepository.new

recipe = repo.find(1)

recipe.id # =>  1
recipe.name # =>  'Lasagna'
recipe.cooking_time # => 45
recipe.rating # =>  4

# Add more examples for each method
```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behavioour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.