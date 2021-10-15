require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  
  let(:movie) { FactoryGirl.create(:movie, title:"Testmovie") }
  let!(:movie1) { FactoryGirl.create(:movie, title: 'Movie1', director: 'DirectorA') }
  let!(:movie2) { FactoryGirl.create(:movie, title: 'Movie2', director: 'DirectorB') }
  let!(:movie3) { FactoryGirl.create(:movie, title: "Movie3", director: 'DirectorA') }
  describe 'Search movies with the same director' do
    
    it 'should call Movie.with_directors model method' do
      Movie.should_receive(:with_director).with(movie.title)
      get :similar, { id: movie.id } #
    end
    
    it 'should assign similar movies if director exists' do
      movies = [movie1.id, movie3.id]
      Movie.stub(:with_director).with(movie1.title).and_return(movies)
      get :similar, { id: movie1.id }
      expect(assigns(:movies)).to eql(movies)
    end
    
    it 'should redirect to home page if no director exists' do
      Movie.stub(:with_director).with(movie.title).and_return(nil)
      get :similar, { id: movie.id }
      expect(response).to redirect_to(movies_path)
    end
  end
end