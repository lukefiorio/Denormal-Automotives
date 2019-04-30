CREATE USER normal_user;
CREATE DATABASE normal_cars;
ALTER DATABASE normal_cars OWNER TO normal_user;

-- make normalized TABLEs
CREATE TABLE makes_models AS
(SELECT DISTINCT
  DENSE_RANK() OVER(ORDER BY make_code, model_code) AS id,
  DENSE_RANK() OVER(ORDER BY make_code, make_title) AS make_id,
  DENSE_RANK() OVER(ORDER BY model_code, model_title) AS model_id
FROM car_models);

CREATE TABLE makes AS
(SELECT DISTINCT
  DENSE_RANK() OVER(ORDER BY make_code, make_title) AS id,
  make_code,
  make_title
FROM car_models);

CREATE TABLE models AS
(SELECT DISTINCT
  DENSE_RANK() OVER(ORDER BY model_code, model_title) AS id,
  model_code,
  model_title
FROM car_models);

CREATE TABLE years AS
(SELECT
  DISTINCT DENSE_RANK() OVER(ORDER BY make_code, model_code) AS makes_models_id,
  year
FROM car_models);

-- all make_titles (no dupes)
SELECT make_title
FROM makes;

-- all model_titles WHERE make = 'VOLKS' (no dupes)
SELECT DISTINCT models.model_title
FROM models
  INNER JOIN makes_models ON makes_models.model_id = models.id
  INNER JOIN makes ON makes.id = makes_models.make_id
WHERE makes.make_code = 'VOLKS';

-- list make_codes, models, and years WHERE make = 'LAM' (no dupes)
SELECT makes.make_code, models.model_code, models.model_title, years.year
FROM models
  INNER JOIN makes_models ON makes_models.model_id = models.id
  INNER JOIN makes ON makes.id = makes_models.make_id
  INNER JOIN years ON years.makes_models_id = makes_models.id
WHERE makes.make_code = 'LAM';

-- list all fields FROM car models between 2010 & 2015 (no dupes)
SELECT makes.make_code, makes.make_title, models.model_code, models.model_title, years.year
FROM makes_models
  INNER JOIN makes ON makes.id = makes_models.make_id
  INNER JOIN models ON models.id = makes_models.model_id
  INNER JOIN years ON years.makes_models_id = makes_models.id
WHERE year BETWEEN 2010 AND 2015;
	