Table config;

void saveConfig() {
  
  config = new Table();
  
  config.addColumn("id");
  config.addColumn("value");
  
  TableRow newRow = config.addRow();
  newRow.setString("id", "displayMode");
  newRow.setString("value", displayMode);
  
  //Booleans
  newRow = config.addRow();
  newRow.setString("id", "showVertexEdges");
  newRow.setInt("value", int(showVertexEdges));
  
  newRow = config.addRow();
  newRow.setString("id", "showReducedResolution");
  newRow.setInt("value", int(showReducedResolution));
  
  newRow = config.addRow();
  newRow.setString("id", "showFrameRate");
  newRow.setInt("value", int(showFrameRate));
  
  newRow = config.addRow();
  newRow.setString("id", "showAutoRotate");
  newRow.setInt("value", int(showAutoRotate));
  
  newRow = config.addRow();
  newRow.setString("id", "showAgents");
  newRow.setInt("value", int(showAgents));
  
  //Sphere
  newRow = config.addRow();
  newRow.setString("id", "pitch3d");
  newRow.setFloat("value", pitch3d.value);
  
  newRow = config.addRow();
  newRow.setString("id", "zoom3d");
  newRow.setFloat("value", zoom3d.value);
  
  newRow = config.addRow();
  newRow.setString("id", "rotate3d");
  newRow.setFloat("value", rotate3d.value);
  
  //Projection
  newRow = config.addRow();
  newRow.setString("id", "w45min");
  newRow.setFloat("value", w45min.value);
  
  newRow = config.addRow();
  newRow.setString("id", "weq");
  newRow.setFloat("value", weq.value);
  
  newRow = config.addRow();
  newRow.setString("id", "w45max");
  newRow.setFloat("value", w45max.value);
  
  newRow = config.addRow();
  newRow.setString("id", "translateX");
  newRow.setFloat("value", translateX.value);
  
  newRow = config.addRow();
  newRow.setString("id", "translateY");
  newRow.setFloat("value", translateY.value);
  
  newRow = config.addRow();
  newRow.setString("id", "rotate");
  newRow.setFloat("value", rotate.value);
  
  newRow = config.addRow();
  newRow.setString("id", "zoom");
  newRow.setFloat("value", zoom.value);
  
  saveTable(config, "data/config.csv");
}

void loadConfig() {
  
  File f = new File(dataPath("config.csv"));
  if(f.exists()) { 

    config = loadTable("config.csv","header");
  
    //DisplayMode
    //displayMode = config.getString(0,1);
  
    //Booleans 5 values
    showVertexEdges = boolean(config.getInt(1,1));
    showReducedResolution = boolean(config.getInt(2,1));
    showFrameRate = boolean(config.getInt(3,1));
    showAutoRotate = boolean(config.getInt(4,1));
    showAgents = boolean(config.getInt(5,1));
  
    //Sphere 3 values
    pitch3d.value = config.getFloat(6,1);
    zoom3d.value = config.getFloat(7,1);
    rotate3d.value = config.getFloat(8,1);
  
    //Projection 7 values
    w45min.value = config.getFloat(9,1);
    weq.value = config.getFloat(10,1);
    w45max.value = config.getFloat(11,1);
  
    translateX.value = config.getFloat(12,1);
    translateY.value = config.getFloat(13,1);
    rotate.value = config.getFloat(14,1);
    zoom.value = config.getFloat(15,1);
  }
  else restoreDefaults();
}