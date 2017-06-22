class EmployeesController < ApplicationController
  before_action :load_employee, only: [:edit, :update, :destroy]

  def index
    respond_with(@employees = Employee.page(params[:page]))
  end

  def new
    respond_with(@employee = Employee.new)
  end

  def edit
    respond_with(@employee)
  end

  def update
    @employee.update(employee_params)
    respond_with @employee, location: -> { employees_path }
  end

  def destroy
    respond_with(@employee.destroy)
  end

  def create
    @employee = Employee.create(employee_params)
    respond_with @employee, location: -> { root_path }
  end

  private

  def employee_params
    params.require(:employee).permit(:uuid, :name, :department, :email, :phone)
  end

  def load_employee
    @employee = Employee.find(params[:id])
  end
end
