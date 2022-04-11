class OnlineHourModel {
  int id;
  int fromHour;
  int toHour;
  int dayInWeek;

  OnlineHourModel({
    required this.id,
    required this.fromHour,
    required this.toHour,
    required this.dayInWeek,
  });
}

List<OnlineHourModel> demoListHour = [
  OnlineHourModel(id: 1, fromHour: 8, toHour: 11, dayInWeek: 2),
  OnlineHourModel(id: 2, fromHour: 8, toHour: 11, dayInWeek: 3),
  OnlineHourModel(id: 3, fromHour: 8, toHour: 11, dayInWeek: 4),
  OnlineHourModel(id: 4, fromHour: 8, toHour: 11, dayInWeek: 5),
  OnlineHourModel(id: 5, fromHour: 8, toHour: 11, dayInWeek: 6),
  OnlineHourModel(id: 6, fromHour: 8, toHour: 11, dayInWeek: 7),
  OnlineHourModel(id: 7, fromHour: 8, toHour: 11, dayInWeek: 8),
  OnlineHourModel(id: 8, fromHour: 13, toHour: 18, dayInWeek: 2),
  OnlineHourModel(id: 9, fromHour: 13, toHour: 18, dayInWeek: 3),
  OnlineHourModel(id: 10, fromHour: 13, toHour: 18, dayInWeek: 4),
  OnlineHourModel(id: 11, fromHour: 13, toHour: 18, dayInWeek: 5),
  OnlineHourModel(id: 12, fromHour: 13, toHour: 18, dayInWeek: 6),
];
