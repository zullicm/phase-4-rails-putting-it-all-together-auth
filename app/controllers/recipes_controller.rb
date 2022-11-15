class RecipesController < ApplicationController

  def index
    recipes = Recipe.all
    render json: recipes, status: :created
  end

  def create
    recipe = Recipe.create(recipe_params)
    recipe.user_id = session[:user_id]
    recipe.save
    if recipe.valid?
      render json: recipe.to_json(include: [:user]), status: :created
    else
      render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

end
