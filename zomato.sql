# For a high-level overview of the hotels, provide us the top 5 most voted hotels in the delivery category.

SELECT name, votes, rating FROM zomato where type = "delivery"
ORDER BY votes DESC LIMIT 5;


# The rating of a hotel is a key identifier in determining a restaurant’s performance. 
# Hence for a particular location called Banashankari find out the top 5 highly rated hotels in the delivery category.

SELECT name, rating, location, type FROM zomato WHERE type = "delivery" AND location = "Banashankari"
ORDER BY rating DESC LIMIT 5;

# compare the ratings of the cheapest and most expensive hotels in Indiranagar.

SELECT (SELECT rating FROM zomato WHERE approx_cost = (SELECT MIN(approx_cost) FROM zomato WHERE location = 'Indiranagar') LIMIT 1) AS rating1,
(SELECT rating FROM zomato WHERE approx_cost = (SELECT MAX(approx_cost) FROM zomato WHERE location = 'Indiranagar') LIMIT 1)
AS rating2 FROM zomato LIMIT 1;


# Online ordering of food has exponentially increased over time. 
# Compare the total votes of restaurants that provide online ordering services and those who don’t provide online ordering service.
SELECT SUM(votes) AS total_votes,online_order FROM zomato WHERE online_order = "Yes"
UNION
SELECT SUM(votes) AS total_votes,online_order FROM zomato WHERE online_order = "No";



# Number of votes defines how much the customers are involved with the service provided by the restaurants For each Restaurant type, 
# find out the number of restaurants, total votes, and average rating.
# Display the data with the highest votes on the top( if the first row of output is NA display the remaining rows).

SELECT type ,COUNT(name),SUM(votes),AVG(rating)
FROM zomato GROUP BY type HAVING type !="NA"
ORDER BY votes DESC;



# What is the most liked dish of the most-voted restaurant on Zomato(as the restaurant has a tie-up with Zomato, 
# the restaurant compulsorily provides online ordering and delivery facilities.

SELECT name, dish_liked, rating, votes FROM zomato WHERE votes = (SELECT MAX(votes) FROM zomato);



# To increase the maximum profit, Zomato is in need to expand its business. 
# For doing so Zomato wants the list of the top 15 restaurants which have min 150 votes,
# have a rating greater than 3, and is currently not providing online ordering. Display the restaurants with highest votes on the top.

SELECT name, votes, rating,online_order FROM zomato WHERE votes >=150 AND rating>3 AND online_order="No" ORDER BY votes DESC LIMIT 15;