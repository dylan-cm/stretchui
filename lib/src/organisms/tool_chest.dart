import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';

class ToolChest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<ArtBloc>(context);
    return Container(
      color: Colors.grey[900],
      width: screen.width*0.1,
      height: screen.height,
      padding: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: 
        <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.remove_red_eye), 
              onPressed: (){},
            ),
            width: screen.width*0.1,
            height: screen.height*0.1,
            alignment: AlignmentDirectional.center,
          ),
        ] +
        <Widget>[Expanded(flex: 4,child: Container())] +
        _buildButton(Icons.add_box, ()=>bloc.addStretchy(), screen) +
        _buildButton(Icons.text_fields, (){}, screen) +
        _buildButton(Icons.image, (){}, screen) +
        _buildButton(Icons.color_lens, (){}, screen) +
        _buildButton(Icons.aspect_ratio, (){}, screen) +
        _buildButton(Icons.crop_free, (){}, screen) +
        _buildButton(Icons.grid_on, (){}, screen) +
        _buildButton(Icons.arrow_drop_up, (){}, screen) +
        _buildButton(Icons.arrow_drop_down, (){}, screen) +
        <Widget>[ Expanded(flex: 3, child: Container())],
      ),
    );
  }

  List<Widget> _buildButton(IconData icon, VoidCallback onPressed, Size screen){
    return [
      RaisedButton(
      color: Colors.grey[800],
      child: Container(
        constraints: BoxConstraints(
          minHeight: 44,
          maxHeight: 78,
        ),
        height: screen.width*0.2,
        child: Icon(icon, size: screen.width*0.04)
      ),
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      ),
      Expanded(
        child: Container(),
        flex: 1,
      ),
    ];
  }
}