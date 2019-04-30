CREATE USER denormal_user;
CREATE DATABASE denormal_cars;
ALTER DATABASE denormal_cars OWNER TO denormal_user;

SELECT DISTINCT make_title
FROM car_models;

SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';

SELECT DISTINCT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';

SELECT *
FROM car_models
WHERE year BETWEEN 2010 AND 2015;