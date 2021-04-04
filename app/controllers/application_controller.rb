class ApplicationController < ActionController::Base
  @categories = Category.all
  @elements = Element.all
end
