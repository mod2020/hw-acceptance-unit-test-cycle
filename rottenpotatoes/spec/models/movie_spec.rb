require 'rails_helper'

RSpec.describe Movie, type: :model do
  
  describe 'When Movie.with_director is called' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Movie1', director: 'DirectorA') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Movie2', director: 'DirectorB') }
    let!(:movie3) { FactoryGirl.create(:movie, title: "Movie3", director: 'DirectorA') }
    let!(:movie4) { FactoryGirl.create(:movie, title: "Stop") }

    context 'if director exists' do
        it 'similar movies are found' do
            Movie.with_director(movie1.title).should include(Movie.find_by_title('Movie1'), Movie.find_by_title("Movie3"))
            Movie.with_director(movie1.title).should_not include(Movie.find_by_title('Movie2'))
            Movie.with_director(movie2.title).should include(Movie.find_by_title('Movie2'))
        end
    end

    context 'if director does not exist' do
        it 'sad path is handled' do
        expect(Movie.find_by_title(movie4.title).director).to eql(nil)
        end
    end
  
  end
end