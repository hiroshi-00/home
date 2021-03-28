class SkillsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @skill = Skill.new
    @skill.update(skill_params)
    redirect_to item_url @item
  end
  
  private
    def skill_params
      params.require(:answer).permit(:skl_name, :skl_detail, :item_id)
    end
end
