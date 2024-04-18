class InventoriesController < ApplicationController
  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      redirect_to lists_path, notice: 'Inventory was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:csv_file)
  end
end
