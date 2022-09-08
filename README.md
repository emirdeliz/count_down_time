# count_down_time

[![Count Down Time: Tests](https://github.com/emirdeliz/count_down_time/actions/workflows/main.yml/badge.svg)](https://github.com/emirdeliz/count_down_time/actions/workflows/main.yml)

This widget render a simple count-down time.

<img src="https://raw.githubusercontent.com/emirdeliz/count_down_time/master/assets/example.gif" width="300" height="auto" alt="Menu float - example"/>

## Getting Started
Below the simple example:

```dart
Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CountDownTime(
        timeId: 'simple-timer',
        color: Colors.red,
        fontSize: 15,
        timeStartInSeconds: 30,
        onChangeTime: (time) {
          setState(() {
            timeoutReached = false;
          });
        },
        onTimeOut: () {
          setState(() {
            timeoutReached = true;
          });
        },
      ),
      Container(
          padding: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text('Restart count'),
            onPressed: () {
              CountDownTimeController.pushTimerRenewId(widget.id);
            },
          )),
      Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(timeoutReached ? 'Timeout Reached' : ''))
    ])
```
For more details see the project demo in the [demo
](https://github.com/emirdeliz/count_down_time/tree/master/count_down_time_demo)folder.

About the props:

| **Prop**  | **Type** | **Description** |
|-----------|----------|---------------------------------------------------------------------|
| **timeId** | String | Define the timer id. |
| **timeStartInSeconds** | int | Define the time to start the count-down in seconds. |
| **fontSize (optional)** | double | Define the fontSize of timer. |
| **color (optional)** | Color | Define the color of timer. |
| **onTimeOut** | Function | Define the callback when the count-down is finished. |
| **onChangeTime** | Function(int time) | Define the callback when the count-down is changed. |

About the factory:

The widget has two factories to work with minutes and hours on count-down start. See the example below:

Minutes:
```dart
CountDownTime.minutes(
	timeStartInMinutes: 2
)
```

Hours:
```dart
CountDownTime.hours(
	timeStartInHours: 2
)
```