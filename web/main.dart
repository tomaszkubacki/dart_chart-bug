// Copyright (c) 2016, Tomasz Kubacki. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' as math;
import 'dart:js' as js;
import 'package:chartjs/chartjs.dart';
import 'package:js/js.dart';


void main() {
  var ctx = (querySelector('#canvas') as CanvasElement).context2D;
  var rnd = new math.Random();
  var months = <String>["January", "February", "March", "April", "May", "June"];

  var config = new ChartConfiguration(
      type: 'pie', data:
  new LinearChartData(labels: months, datasets: <ChartDataSets>[
    new ChartDataSets(
        label: "",
        backgroundColor: [
          "#2196F3",
          "#F44336",
          "#673AB7",
          "#009688",
          "#E91E63",
          "#673AB7",
          "#FF9800",
          "#8BC34A",
          "#607D8B",
          "#3F51B5"
        ],
        data: months.map((_) => rnd.nextInt(100)).toList())
  ])
  ,
      options: new ChartOptions(responsive:false, onClick: js.allowInteropCaptureThis(([t,a,b]){
    if(b != null && b is List && b.length > 0){
      js.JsObject obj = new js.JsObject.fromBrowserObject(b[0]);
      int index = obj["_index"];
      print(index); ///!!!BUG - this is always null on dartjs and correct in dart/dartium
    }
  }) ) );

  var chart = new Chart(ctx, config);


  chart.update();


}
