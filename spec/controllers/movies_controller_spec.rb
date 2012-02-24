require "spec_helper"

describe MoviesController do
  describe 'finding movies with a similar director' do
    context 'when the movie has a director' do
      before :each do
        #@fake_movie = mock 'movie'
        #@fake_movie.stub 'director', 'FAMOUS MOVIE DIRECTOR NAME HERE'
        #@fake_movie.stub 'title', 'Welcome to CS169!'
        #@fake_movie.id 'id', 1
        @fake_movie = mock('movie1', :id => '1', :title => 'title', :director => 'dir')
        @fake_results = [mock('Movie'), mock('Movie'), mock('Movie')]
      end
      
      it 'should call the movie method :find_similar' do
        Movie.should_receive(:find_by_id).and_return(@fake_movie)
        @fake_movie.should_receive(:find_similar).and_return(@fake_results)
        get :similar, {:id => 1}
      end
      
      it 'should render the similar_movies view' do
        Movie.should_receive(:find_by_id).and_return(@fake_movie)
        @fake_movie.should_receive(:find_similar).and_return(@fake_results)
        get :similar, {:id => 1}
        response.should render_template('similar')
      end
      
      it 'should make the similar movies available to that template' do
        Movie.should_receive(:find_by_id).and_return(@fake_movie)
        @fake_movie.should_receive(:find_similar).and_return(@fake_results)
        
        
        get :similar, {:id => '1'.to_i}
        assigns(:results).should == @fake_results
      end
    end
    
    context 'when the movie has no director info' do
      it 'should redirect to the homepage and flash a notice' do
        @fake_movie2 = mock('movie2', :id => '1', :title => 'title', :director => nil)
        #@fake_movie.id 'id', 1
        Movie.should_receive(:find_by_id).and_return(@fake_movie2)
        @fake_movie2.should_not_receive(:find_similar)
        get :similar, {:id => 1}
        response.should redirect_to(movies_path)
        flash[:notice].should == "'#{@fake_movie2.title}' has no director info."
      end      
    end
  end
  
  describe "Testing to create and delete a movie" do
    it "should create a movie and delete and go back to index page" do
      post :create, {:movie_title => "dsa", :movie_rating => "PG", :movie_director => "Director", :movie_release_date => "01-Jan-1800"}
      response.should redirect_to(movies_path)
      post :destroy, {:id => 1}
      response.should redirect_to(movies_path)
    end
  end
end
