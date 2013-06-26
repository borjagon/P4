require 'spec_helper'

describe MoviesController do
  describe "index" do
    it "should sort by 'title' when :sort is 'title'" do
      get :index, :sort => 'title'
      assigns[:title_header].should == 'hilite'
    end

    it "should sort by 'release_date' when :sort is 'release_date'" do
      get :index, :sort => 'release_date'
      assigns[:date_header].should == 'hilite'
    end
    
    it "should filter movies" do
      get :index, :ratings => 'G'
      assigns[:selected_ratings].should == 'G'
    end
    it "should call the model find_all_by_rating" do
      Movie.should_receive(:find_all_by_rating).and_return(@fake_movie)
      get :index
      assigns[:movies].should == @fake_movie
    end
  end
  

  describe "edit" do
    it "change the movie for @movie" do
      Movie.stub!(:find).with("1").and_return(@fake_movie)
      get :edit, :id => "1"
      assigns[:movie].should == @fake_movie
      response.should render_template("edit")
    end
  end
    
  describe "new" do
    it "should select new movie" do
      get :new
      response.should render_template('new')
    end
  end

  describe "create" do
    it "should redirect to movies path when created" do
      post :create, :movie => {:title => "star wars"}
      response.should redirect_to movies_path
    end
  end

  describe "show" do
    it "should assign movie to @movie" do
      Movie.stub!(:find).with("1").and_return(@fake_movie)
      get :show, :id => "1"
      assigns[:movie].should == @fake_movie
      response.should render_template("show")
    end
  end

  describe "delete movie" do
    before :each do
      @fake_movie = mock('movie', :id => '1', :title => 'title')
      Movie.stub(:find).and_return(@fake_movie)
      @fake_movie.should_receive(:destroy)
    end
    it "should call destroy" do
      delete :destroy, :id => @fake_movie.id
    end
    it "should go back to the home page" do
      delete :destroy, :id => @fake_movie.id
      response.should redirect_to(movies_path)
    end
  end

  describe "update move" do
    before :each do
      @fake_movie = mock('movie', :id => '1', :title => 'title')
      @fake_rating = 'G'
      Movie.stub(:find).and_return(@fake_movie)
      @fake_movie.should_receive(:update_attributes!).with("rating" => @fake_rating)
    end
    it "should update_attributes!" do
      put :update, :id => @fake_movie.id, :movie => {:rating => @fake_rating}
    end
  end
  describe 'TMDb' do
    before :each do
      @fake_search = PatchedOpenStruct.new
    end
    it "should call the search_tmdb model" do
      Movie.should_receive(:find_in_tmdb).with('happy').and_return(@fake_search)
      post :search_tmdb, {:search_terms => 'happy'}
    end
  end

  describe 'Invalid Api key' do
    before :each do
      TmdbMovie.stub(:find).and_raise(RuntimeError.new("API status code '404'"))
      post :search_tmdb, {:search_terms => 'happy'}
    end
    it "should raise InvalidKeyError" do
      response.should redirect_to movies_path
    end
  end
  describe "No API key" do
    before :each do
      Movie.stub(:api_key).and_return('')
      post :search_tmdb, {:search_terms => 'sad'}
    end
    it "should raise InvalidKeyError" do
      response.should redirect_to movies_path
    end
  end
  
  describe "Succesful Search" do
    before :each do
      Movie.stub(:find_in_tmdb).and_return(@fake_search)
      post :search_tmdb, {:search_terms => 'happy'}
    end
    it "should use the Search Results template" do
      response.should render_template('search_tmdb')
    end
  end

  describe "Invalid Search" do
    before :each do
      Movie.stub(:find_in_tmdb).and_return([])
      post :search_tmdb, {:search_terms => 'sad'}
    end
    it "should go back to index" do
      response.should redirect_to movies_path
    end
    it "should show an alert message" do
      flash[:notice].should == "'sad' was not found in TMDb."
    end
  end



end
