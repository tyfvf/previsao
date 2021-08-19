import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:previsao/models/weather.dart';
import 'package:previsao/screens/shared/find_icon.dart';
import 'package:previsao/screens/weather_view.dart';

class MainScreen extends StatelessWidget {
  final Map data;

  const MainScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () => Phoenix.rebirth(context), icon: Icon(Icons.replay_outlined, color: Colors.white,)),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  this.data["city"],
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    this.data["date"],
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SvgPicture.asset(
                  findIcon(this.data["condition_slug"]),
                  width: 50,
                ),
                Text(
                  "${this.data["temp"]}°",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  this.data["description"],
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: SvgPicture.asset("assets/images/vento.svg"),
                ),
                Text(
                  this.data["wind_speedy"].toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemBuilder: builder,
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget builder(BuildContext context, int index) {
    Weather weather = Weather(
      dayOfWeek: this.data["forecast"][index]["weekday"],
      icon: findIcon(this.data["forecast"][index]["condition"]),
      temperature: this.data["forecast"][index]["max"],
    );
    return WeatherView(weather);
  }
}
