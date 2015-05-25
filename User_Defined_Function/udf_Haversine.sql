CREATE FUNCTION HAVERSINE (lat1 DOUBLE, lon1 DOUBLE, lat2 DOUBLE, lon2 DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE dist DOUBLE;
    SET dist =  round(acos(cos(radians(lat1))*cos(radians(lon1))*cos(radians(lat2))*cos(radians(lon2)) + cos(radians(lat1))*sin(radians(lon1))*cos(radians(lat2))*sin(radians(lon2)) + sin(radians(lat1))*sin(radians(lat2))) * 6372.8, 1);
    RETURN dist;
END
