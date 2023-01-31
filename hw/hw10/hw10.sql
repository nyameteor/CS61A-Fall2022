CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT a.child AS name
    FROM parents AS a, dogs AS b, dogs AS c
    WHERE a.child = b.name AND
          a.parent = c.name
    ORDER BY c.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name AS name, b.size AS size
    FROM dogs AS a, sizes AS b
    WHERE a.height > b.min AND
          a.height <= b.max;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS first, b.child AS second
    FROM parents AS a, parents AS b
    WHERE a.parent = b.parent AND
          a.child < b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || a.first || " plus " || a.second || " have the same size: " || b.size
    FROM siblings AS a, size_of_dogs AS b, size_of_dogs AS c
    WHERE a.first = b.name AND
          a.second = c.name AND
          b.size = c.size;

