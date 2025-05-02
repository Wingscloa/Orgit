import 'dart:collection';
import 'dart:typed_data';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/Components/Inputs/title_input.dart';
import 'package:flutter/material.dart';
import 'package:orgit/Components/Bar/slide_bar.dart';
import 'package:orgit/Components/Inputs/avatar_input.dart';
import 'package:image_picker/image_picker.dart';

class Mdlgroupcreate extends StatefulWidget {
  @override
  State<Mdlgroupcreate> createState() => _MdlgroupcreateState();
}

class _MdlgroupcreateState extends State<Mdlgroupcreate> {
  final _picker = ImagePicker();
  final _titleCont = TextEditingController();
  final _regionCont = TextEditingController();
  final _city = TextEditingController();
  final _description = TextEditingController();
  Uint8List? image;

  static List<String> ceskeKraje = [
    'Hlavní město Praha',
    'Středočeský kraj',
    'Jihočeský kraj',
    'Plzeňský kraj',
    'Karlovarský kraj',
    'Ústecký kraj',
    'Liberecký kraj',
    'Královéhradecký kraj',
    'Pardubický kraj',
    'Vysočina',
    'Jihomoravský kraj',
    'Olomoucký kraj',
    'Zlínský kraj',
    'Moravskoslezský kraj',
  ];

  List<DropdownMenuEntry> regionEntries =
      UnmodifiableListView<DropdownMenuEntry>(
    List.generate(
      ceskeKraje.length,
      (index) => DropdownMenuEntry(
        value: index,
        label: ceskeKraje[index],
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )),
          backgroundColor: WidgetStatePropertyAll(
            Color.fromARGB(255, 26, 27, 29),
          ),
        ),
      ),
    ),
  );

  static List<String> cities = [
    "Bílina",
    "Chomutov",
    "Děčín",
    "Dubí",
    "Kadaň",
    "Krupka",
    "Litoměřice",
    "Litvínov",
    "Louny",
    "Lovosice",
    "Meziboří",
    "Most",
    "Podbořany",
    "Postoloprty",
    "Roudnice nad Labem",
    "Rumburk",
    "Šluknov",
    "Teplice",
    "Ústí nad Labem",
    "Varnsdorf",
    "Žatec",
  ];

  List<DropdownMenuEntry> citiesEntries =
      UnmodifiableListView<DropdownMenuEntry>(
    List.generate(
      cities.length,
      (index) => DropdownMenuEntry(
        value: index,
        label: cities[index],
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )),
          backgroundColor: WidgetStatePropertyAll(
            Color.fromARGB(255, 26, 27, 29),
          ),
        ),
      ),
    ),
  );

  Future<void> _selectImage() async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      image = await selectedImage.readAsBytes();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 20, 22),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      height: 725,
      width: double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SlideBar(),
          ),
          Positioned(
            left: 55,
            top: 40,
            child: Text(
              'Vytvořit skupinu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AvatarInput(
                    image: image,
                    onTap: _selectImage,
                  ),
                  SizedBox(height: 20),
                  TitleInput(controller: _titleCont, value: 'Název skupiny'),
                  SizedBox(
                    height: 20,
                  ),
                  MineDropDown(
                    regionCont: _regionCont,
                    regionEntries: regionEntries,
                    labelText: "KRAJ",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MineDropDown(
                      regionCont: _city,
                      regionEntries: citiesEntries,
                      labelText: "MĚSTO"),
                  SizedBox(
                    height: 20,
                  ),
                  TextArea(controller: _description),
                  SizedBox(
                    height: 20,
                  ),
                  Defaultbutton(
                      textColor: Colors.black,
                      text: "Vytvořit skupinu",
                      color: Color.fromARGB(255, 255, 203, 105),
                      onTap: () => {print("vytvorit skupinu")})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(
          color: Color.fromARGB(255, 94, 95, 96),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          maxLines: 8, //or null
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.w600,
            ),
            hintText: "popis",
          ),
        ),
      ),
    );
  }
}

class MineDropDown extends StatelessWidget {
  MineDropDown({
    super.key,
    required TextEditingController regionCont,
    required this.regionEntries,
    required this.labelText,
  }) : _regionCont = regionCont;

  final TextEditingController _regionCont;
  final List<DropdownMenuEntry> regionEntries;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<dynamic>(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color.fromARGB(255, 26, 27, 29),
        ),
      ),
      enableSearch: false,
      enableFilter: false,
      textStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      menuHeight: 200,
      controller: _regionCont,
      label: Text(
        labelText,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      dropdownMenuEntries: regionEntries,
    );
  }
}
