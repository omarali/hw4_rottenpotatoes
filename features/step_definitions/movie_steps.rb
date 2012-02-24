# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.find_by_title(movie[:title]) or Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.html =~ /#{e1}.*#{e2}/m, "#{e1} is not appearing before #{e2}"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').map{ |x| x.strip }.each { |rating| step "I #{uncheck}check the rating #{rating}" }
end

When /^(?:|I )check the rating ([^"]*)$/ do |field|
  check("ratings_"+field)
end

When /^(?:|I )uncheck the rating ([^"]*)$/ do |field|
  uncheck("ratings_"+field)
end

Then /^(?:|I )should not see any of the movies$/ do
  Movie.all.each { |m| page.should have_no_content(m.title) }
end

Then /^(?:|I )should see all of the movies$/ do
  Movie.all.each { |m| page.should have_content(m.title) }
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  assert page.html =~ /Director:.*#{arg2}/im
end
