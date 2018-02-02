//Lat Lon to canvas position
float lattoCanvasY(float lat) {
  return canvas.height*(1.0-(lat+90)/180.0);
}

float lontoCanvasX(float lon) {
  return (lon+180)/360.0*canvas.width;
}

PVector latlontoCanvasXY(PVector latlon) {
  PVector pos = new PVector(lontoCanvasX(latlon.y), lattoCanvasY(latlon.x));
  return pos;
}