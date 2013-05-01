class Admin::ProductsController < ApplicationController

  def index
    if current_store.users.include?(current_user)
      @dashboard = Dashboard.new(current_store, current_user)
    else
      flash[:error] = "Sorry, only store admins may access this page."
      redirect_to root_url
    end
  end

  def new
    @product = current_store.products.build
    @categories = current_store.categories
  end

  def edit
    @product = current_store.products.find(params[:id])
    @categories = current_store.categories
  end

  def create
    @product = current_store.products.build(params[:product])

    if @product.save
      redirect_to admin_products_path(current_store),
        notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    params[:product][:retired] ||= []
    params[:product][:category_ids] ||= []
    @product = current_store.products.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to admin_products_path(current_store),
        notice: 'Product was successfully updated.'
    else
      flash[:error] = 'Product was not updated'
      redirect_to admin_product_path(store_id: current_store.to_param, id: @product.id),
        notice: 'Product was successfully created.'
    end
  end

  def destroy
    @product = current_store.products.find(params[:id])
    @product.destroy

    redirect_to admin_products_path
  end

  def show
    @product = current_store.products.find(params[:id])

    if @product.retired == true
      redirect_to home_path(current_store)
    else
      render :show
    end
  end

  def retire
    product = current_store.products.find(params[:id])
    product.retired = true
    product.save

    redirect_to admin_products_path, notice: "Product is now retired"
  end

  def unretire
    product = current_store.products.find(params[:id])
    product.retired = false
    product.save

    redirect_to admin_products_path, notice: "Product is active"
  end
end
