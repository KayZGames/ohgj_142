import 'package:dartemis/dartemis.dart';

class Controller extends Component {
  bool up, down, left, right;
  
  Controller(
      {this.up: false, this.down: false, this.left: false, this.right: false});
}
