class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:id])
    cart = Cart.new(session[:cart])
    cart.add_pet(pet)
    session[:cart] = cart.contents
    flash[:notice] = "Pet has been added to my favorites list."
    redirect_to "/pets/#{pet.id}"
  end

end

#{pluralize(quantity, "copy")} of #{song.title} in your cart.
