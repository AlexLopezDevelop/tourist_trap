class Tool {

  String distanceCalculator(double distance) {
    if (distance.toString().length > 3) {
      distance = double.parse(distance.toString())/1000;
      return distance.roundToDouble().toString() + " km";
    }

    return distance.roundToDouble().toString() + " m";
  }
}