// Copyright (c) 2016, Tomasz Kubacki. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' as math;
import 'package:chartjs/chartjs.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;


void main() {
  var ctx = (querySelector('#canvas') as CanvasElement).context2D;
  var rnd = new math.Random();
  var months = <String>["January", "February", "March", "April", "May", "June"];
  List dataVals = months.map((_) => rnd.nextInt(100)).toList();

  List colors = [
    "#2196F3",
    "#F44336",
    "#3F51B5",
    "#009688",
    "#E91E63",
    "#673AB7",
    "#FF9800",
    "#8BC34A",
    "#607D8B"
  ];

  Chart chart;

  var config = new ChartConfiguration(
      type: 'pie', data:
  new LinearChartData(labels: months, datasets: <ChartDataSets>[
    new ChartDataSets(
        label: "",
        backgroundColor: colors,
        data: dataVals)
  ])
  ,
      options: new ChartOptions(responsive:false, onClick: allowInteropCaptureThis(([t,a,b]){
        if(b != null && b is List && b.length > 0){
          var obj = b[0];
          int index = js_util.getProperty(obj, "_index");
          List newColors = colors.map((c)=> colors.indexOf(c) == index ? "#ffff00" : c ).toList(growable: false);
          chart.config.data = new LinearChartData(labels: months, datasets: <ChartDataSets>[
            new ChartDataSets(
                label: "",
                backgroundColor: newColors,
                data: dataVals)
          ]);

          chart.update({"duration": 0});
        }
  }) ) );

  chart = new Chart(ctx, config);



}
