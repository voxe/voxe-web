# encoding: UTF-8
class NewAdmin::CountriesController < AdminController
  load_and_authorize_resource find_by: :namespace


  def index
    @countries = Country.all.order_by name: :asc
    @country ||= Country.new
  end


  def create
    if @country.save
      flash[:notice] = "#{@country} a bien été créé"
      respond_with :new_admin, @country, location: new_admin_countries_path
    else
      load_countries
      flash[:error] = "Une erreur est survenue, veuilles réessayer"
      redirect_to :back
    end
  end


  def destroy
    @country.destroy
    flash[:notice] = "#{@country} a bien été supprimé"
    respond_with :new_admin, @country
  end


  def edit
  end


  def update
    if @country.update_attributes(params[:country])
      flash[:notice] = "#{@country} a bien été modifié"
      respond_with :new_admin, @country, location: new_admin_countries_path
    else
      load_countries
      flash[:error] = "Une erreur est survenue, veuillez réessayer"
      redirect_to :back
    end
  end


end
