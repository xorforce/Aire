# Aire
Aire, meaning "Air" in Latin, is a simple iOS Application, completely written in Swift and powered by the AirVisual API, gives realtime information about the AQI (Air Quality Index) of your surroundings, so you can plan out your trip accordingly.
<br>Screenshots: <br><br>
![alt_text](https://cloud.githubusercontent.com/assets/14857735/23821070/1f02ba32-064e-11e7-9a81-3fc623712b29.png)
![alt_text](https://cloud.githubusercontent.com/assets/14857735/23821071/1f0323f0-064e-11e7-98ec-ff011457440c.png)
<br>

## To-Do
1. Handle small bugs appropriately
2. Cache data for upto 2 hours

### I downloaded the project, what now?
1. Go to the file directory and do a ```pod install```. You must have Cocoapods installed on your system. For more information on Cocoapods, visit [here](https://cocoapods.org/).
2. Next, go to "Constants.swift" under the "Utils" folder. Hop on to line 14 and insert your AirVisual API key. You can get one [here](https://airvisual.com/api).
3. open ```Aire.xcworkspace```
4. Build and Run the project!

### Requirements
1. Swift 3.0+
2. Xcode 8.0+
3. Cocoapods 1.2.0 (Beta), should work with the stable release as well, although not tested.
