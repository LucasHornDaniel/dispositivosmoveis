import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectListIcon extends StatelessWidget {
  final String status;

  SelectListIcon(this.status);

  @override
  Widget build(BuildContext context) {
    switch(status){
      case "Pendente":
        return Icon(MdiIcons.timerSand, color: Colors.red);
        break;
      case "Aguardando Confirmação":
        return Icon(MdiIcons.timer, color: Colors.yellow);
        break;
      case "Aguardando Técnico":
        return Icon(MdiIcons.timerSand, color: Colors.yellow);
        break;
      case "Pronto":
        return Icon(Icons.check, color: Colors.green);
        break;
      case "Entregue":
        return Icon(MdiIcons.checkCircleOutline, color: Colors.green);
        break;
      default:
        return Icon(Icons.description, color: Colors.green);
        break;
    }
  }
}
