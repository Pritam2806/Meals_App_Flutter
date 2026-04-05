import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/dummy_data.dart';

// ref.read -> To get the data from our provider once
// ref.watch -> To setup a listener, succh that build method is executed again as our data changes
// watch is always more preffered than read. Watch always need a "provider" as a arguement and always return data.

final mealsProvider = Provider((ref) {
  return dummyMeals;
}); 

