class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      flash.now[:error] = company_errors
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit
    end
  end

  def destroy
    if @company.destroy
      redirect_to companies_path, notice: 'Company deleted'
    else
      flash[:error] = company_errors
      redirect_to request.referrer
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def not_found_response
    flash[:error] = 'Company not found'
    redirect_to companies_path
  end

  def company_errors
    @company.errors.full_messages.join(',')
  end

end
