.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet
    FROM students
    WHERE color = 'blue' AND
          pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song
    FROM students
    WHERE color = 'blue' AND
          pet = 'dog';


CREATE TABLE smallest_int_having AS
  SELECT time, smallest
    FROM students
    GROUP BY smallest
      HAVING COUNT(smallest) = 1;


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color
    FROM students a, students b
    WHERE a.pet = b.pet AND
          a.song = b.song AND
          a.time < b.time;


CREATE TABLE sevens AS
  SELECT a.seven
    FROM students a, numbers b
    WHERE a.time = b.time AND
          a.number = 7 AND
          b.'7' = 'True';


CREATE TABLE average_prices AS
  SELECT category, AVG(MSRP) AS average_price
    FROM products
    GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT store, item, MIN(price)
    FROM inventory
    GROUP BY item;


CREATE TABLE lowest_costs AS
  SELECT name, MIN(MSRP/rating) AS cost
    FROM products
    GROUP BY category;


CREATE TABLE shopping_list AS
  SELECT a.name, b.store
    FROM lowest_costs a, lowest_prices b
    WHERE a.name = b.item;


CREATE TABLE total_bandwidth AS
  SELECT SUM(b.Mbs)
    FROM shopping_list a, stores b
    WHERE a.store = b.store;

