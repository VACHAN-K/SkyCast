import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  var weatherdata;
  LocationScreen(this.weatherdata);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var latitude, longitude, description, temperature;
  String? city, weathercode, message;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    updateUI(widget.weatherdata);
    //because location screen class and state class are different but are linked, 'widget'keyword  is used to tap into parent widget of state widget
  }

  void updateUI(dynamic data) {
    setState(() {

      if (data == null) {
        temperature = 0;
        weathercode = "--";
        message = "invalid city";
        city = "input";
        description="error";

        return;
      }
      city = data['name'];if(city=="Kanija Bhavan") city = "Bengaluru";
      description = data['weather'][0]['description'];
      longitude = data['coord']['lon'];
      latitude = data['coord']['lat'];
      print('$latitude  $longitude');

      double temp = data['main']['temp'];
      temperature = temp.toInt();

      int tempcode = data['weather'][0]['id'];
      weathercode = weatherModel.getWeatherIcon(tempcode);
      message = weatherModel.getMessage(tempcode);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weatherModel.getLocationWeather();
                      updateUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //Navigator push take take back a future value when popped,see 154 video in clima
                      var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (typedName != null) {
                        var weatherdata =
                            await weatherModel.getCityWeather(typedName);
                        print('hello  $weatherdata');
                        updateUI(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Text(
                          // '32°',
                          '$temperature°C ',
                          style: kTempTextStyle,
                        ),
                        Text(
                          // '☀️',
                          '$weathercode',
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                    Text('$description',style: kButtonTextStyle,)
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  // "It's 🍦 time in San Francisco!",
                  '$message in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
