class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:id])
    # cart = Cart.new(session[:cart])
    cart.add_pet(pet.id)
    session[:cart] = cart.contents
    flash[:notice] = "Pet has been added to my favorites list."
    redirect_to "/pets/#{pet.id}"
  end

  def delete 
    pet = Pet.find(params[:id])
    cart.remove_pet(pet.id)
    redirect_to "/favorites"
  end
  

end

#{pluralize(quantity, "copy")} of #{song.title} in your cart.
