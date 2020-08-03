import 'package:passenger/block/news_block.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//Add providers here
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<NewsBloc>(create: (_) => NewsBloc()),
];