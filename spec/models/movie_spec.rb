require "spec_helper"

describe Movie do
  describe 'finding movies with a similar director' do
    it 'should call find_all_movies_by_director and return a list of results' do
      @fake_movie    = mock('Movie')
      @fake_results = [mock('Movie'), mock('Movie')]
      @fake_movie.stub(:director).and_return(@fake_director)
      @fake_movie.stub(:find_all_by_director).and_return(@fake_results)
      @fake_movie.should_receive(:find_similar).and_return(@fake_results)
      @fake_movie.find_similar
    end
  end
end
