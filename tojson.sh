# conversion CSV vers geojson (avec csvkit, sed et jq)
csvjson -t Routes_2014.csv \
| jq . \
| sed 's/"\([0-9\.]*\)"/0\1/' \
| jq '{"type":"FeatureCollection","features":[.[] | {"type":"Feature","properties":{"route":.route,"longueur":.longueur,"prD":.prD,"depPrD":.depPrD,"concessionPrD":.concessionPrD,"absD":.absD,"prF":.prF,"depPrF":.depPrF,"concessionPrF":.concessionPrF,"absF":.absF},"geometry":{"type":"LineString","coordinates":[[.xD,.yD],[.xF,.yF]]}}]}' \
> temp.json
# reprojection en WGS84 pour un geojson conforme RFC
ogr2ogr -f geojson Routes_2014.json -s_srs EPSG:2154 -t_srs EPSG:4326 temp.json

