# Add a declarative step here for populating the DB with movies.

value = 0
Given /the following movies exist/ do |movies_table|
  value = 0
  movies_table.hashes.each do |movie|
      Movie.create!(movie)
      value += 1
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  # puts page.body
  #assert page.body =~ /#{e1}.*#{e2}/m
  # match = /#{e1}.*#{e2}/m =~ page.body
  # assert !match.nil?
  page.body.index(e1).should < page.body.index(e2)
end

Then /I should see all of the movies/ do
  page.should have_css("table#movies tbody tr",:count => value.to_i)
end

Then /I should not see all of the movies/ do
  page.should have_css("table#movies tbody tr",:count => value.to_i == 0) 
end

#HW4
Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  movie.director.should == director
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  if uncheck.nil?
    rating_list.split(',').each do |field|
      check("ratings["+field.strip+"]")
    end
  else
    rating_list.split(',').each do |field|
      uncheck("ratings["+field.strip+"]")
    end
  end
end

# When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
#   # HINT: use String#split to split up the rating_list, then
#   #   iterate over the ratings and reuse the "When I check..." or
#   #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
#   ratings = rating_list.split(", ")
#   ratings.each do |rating|
#     if uncheck
#       step "I uncheck \"ratings_" + rating + "\""
#     else
#       step "I check \"ratings_" + rating + "\""
#     end
#   end
# end

