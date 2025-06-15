import 'package:flutter/material.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/models/event_dto.dart';

class Calendarpage extends StatefulWidget {
  @override
  State<Calendarpage> createState() => _CalendarpageState();
}

class _CalendarpageState extends State<Calendarpage> {
  DateTime filterDatum = DateTime.now();

  String _getMonthName(int month) {
    const monthNames = [
      'Leden',
      'Únor',
      'Březen',
      'Duben',
      'Květen',
      'Červen',
      'Červenec',
      'Srpen',
      'Září',
      'Říjen',
      'Listopad',
      'Prosinec'
    ];
    return monthNames[month - 1];
  }

  bool userEvent = true;

  List<EventDto> userEvents = [
    // Uživatelská událost 1 - Narozeniny
    EventDto(
      creator: 1, // ID aktuálního uživatele
      name: 'Narozeniny Adama',
      color: 'FF4081', // Růžová
      description:
          'Oslava narozenin kamaráda Adama, bude občerstvení a hudba, přines dárek!',
      address: 'Pražská 123, Praha 1',
      begins:
          DateTime.now().add(Duration(days: 4, hours: 18)), // Za 4 dny v 18:00
      ends:
          DateTime.now().add(Duration(days: 4, hours: 23)), // Za 4 dny ve 23:00
      createdAt: DateTime.now().subtract(Duration(days: 15)),
      iconId: 3, // ID ikony dortu
    ),

    // Uživatelská událost 2 - Doktor
    EventDto(
      creator: 1, // ID aktuálního uživatele
      name: 'Návštěva lékaře',
      color: '2196F3', // Modrá
      description:
          'Pravidelná zdravotní prohlídka u praktického lékaře. Nezapomenout kartičku pojištěnce.',
      address: 'Zdravotnická 45, Praha 5',
      begins: DateTime.now()
          .add(Duration(days: 7, hours: 9, minutes: 30)), // Za týden v 9:30
      ends: DateTime.now()
          .add(Duration(days: 7, hours: 10, minutes: 30)), // Za týden v 10:30
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      iconId: 12, // ID ikony doktora
    ),

    // Uživatelská událost 3 - Sport
    EventDto(
      creator: 1, // ID aktuálního uživatele
      name: 'Fotbalový zápas',
      color: '4CAF50', // Zelená
      description:
          'Přátelský fotbalový zápas s kolegy z práce. Vzít si vlastní vybavení!',
      address: 'Sportovní areál Podolí, Praha 4',
      begins: DateTime.now().add(Duration(days: 1, hours: 17)), // Zítra v 17:00
      ends: DateTime.now().add(Duration(days: 1, hours: 19)), // Zítra v 19:00
      createdAt: DateTime.now().subtract(Duration(days: 5)),
      iconId: 8, // ID ikony míče
    ),

    // Uživatelská událost 4 - Pracovní
    EventDto(
      creator: 1, // ID aktuálního uživatele
      name: 'Pohovor na novou pozici',
      color: '9C27B0', // Fialová
      description:
          'Pohovor na pozici senior vývojáře. Připravit si portfolio a reference.',
      address: 'Technologická 789, Praha 2',
      begins: DateTime.now()
          .add(Duration(days: 10, hours: 14)), // Za 10 dní ve 14:00
      ends: DateTime.now()
          .add(Duration(days: 10, hours: 15, minutes: 30)), // Za 10 dní v 15:30
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      iconId: 5, // ID ikony kufříku
    ),
  ];

  List<EventDto> groupEvents = [
    // Skupinová událost 1 - Výlet
    EventDto(
      groupId: 1, // ID skupiny "Přátelé z vysoké"
      creator: 2, // ID uživatele Marie (vytváří událost)
      name: 'Výlet na Karlštejn',
      color: '2196F3', // Modrá
      description:
          'Celodenní výlet na hrad Karlštejn s prohlídkou a piknikem. Sraz před nádražím, jízdenky koupíme na místě.',
      address: 'Hlavní nádraží, Praha 1',
      begins:
          DateTime.now().add(Duration(days: 14, hours: 9)), // Za 14 dní v 9:00
      ends: DateTime.now()
          .add(Duration(days: 14, hours: 20)), // Za 14 dní ve 20:00
      createdAt: DateTime.now().subtract(Duration(days: 20)),
      iconId: 7, // ID ikony hradu
    ),

    // Skupinová událost 2 - Festival
    EventDto(
      groupId: 2, // ID skupiny "Hudební nadšenci"
      creator: 3, // ID uživatele Jan (vytváří událost)
      name: 'Letní festival Rock v parku',
      color: 'FF9800', // Oranžová
      description:
          'Dvoudenní hudební festival s mnoha kapelami. Možnost přespání ve stanovém městečku.',
      address: 'Letňanský park, Praha 9',
      begins: DateTime.now().add(Duration(days: 21)), // Za 21 dní
      ends: DateTime.now().add(Duration(days: 23)), // Za 23 dní
      createdAt: DateTime.now().subtract(Duration(days: 45)),
      iconId: 9, // ID ikony hudební noty
    ),

    // Skupinová událost 3 - Školení
    EventDto(
      groupId: 3, // ID skupiny "Pracovní tým"
      creator: 4, // ID uživatele Petr (vytváří událost)
      name: 'Školení Flutter vývoje',
      color: '00BCD4', // Tyrkysová
      description:
          'Celodenní školení zaměřené na pokročilé techniky vývoje mobilních aplikací ve Flutteru.',
      address: 'Technologické centrum, Vinohradská 47, Praha 2',
      begins:
          DateTime.now().add(Duration(days: 5, hours: 9)), // Za 5 dní v 9:00
      ends:
          DateTime.now().add(Duration(days: 5, hours: 17)), // Za 5 dní v 17:00
      createdAt: DateTime.now().subtract(Duration(days: 12)),
      iconId: 15, // ID ikony počítače
    ),

    // Skupinová událost 4 - Meetup
    EventDto(
      groupId: 1, // ID skupiny "Přátelé z vysoké"
      creator: 2, // ID uživatele Marie (vytváří událost)
      name: 'Sraz po 5 letech',
      color: 'FFCB69', // Výchozí zlatá
      description:
          'Pravidelný sraz spolužáků z vysoké školy. Rezervovaný salónek v restauraci.',
      address: 'Restaurace U Modré kachničky, Malá Strana, Praha 1',
      begins: DateTime.now()
          .add(Duration(days: 30, hours: 19)), // Za 30 dní v 19:00
      ends: DateTime.now()
          .add(Duration(days: 30, hours: 23)), // Za 30 dní ve 23:00
      createdAt: DateTime.now().subtract(Duration(days: 60)),
      iconId: 22, // ID ikony skleničky
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.background,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kalendář akcí",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 20),
            Kalendar(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CalendarSection(
                  isActivate: userEvent,
                  text: "MOJE AKCE",
                  onTap: () => setState(() {
                    print("MOJE AKCE");
                    userEvent = true;
                  }),
                ),
                CalendarSection(
                  isActivate: !userEvent,
                  text: "AKCE MÉ SKUPINY",
                  onTap: () => setState(() {
                    print("AKCE MÉ SKUPINY");
                    userEvent = false;
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox Kalendar() {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (filterDatum.month == 1) {
                  filterDatum = DateTime(filterDatum.year - 1, 12);
                } else {
                  filterDatum =
                      DateTime(filterDatum.year, filterDatum.month - 1);
                }
              });
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          Expanded(
            child: Text(
              "${_getMonthName(filterDatum.month)} ${filterDatum.year}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(255, 203, 105, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (filterDatum.month == 12) {
                  filterDatum = DateTime(filterDatum.year + 1, 1);
                } else {
                  filterDatum =
                      DateTime(filterDatum.year, filterDatum.month + 1);
                }
              });
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarSection extends StatelessWidget {
  final bool isActivate;
  final String text;
  final VoidCallback? onTap;
  const CalendarSection({
    super.key,
    required this.isActivate,
    this.text = "MOJE AKCE",
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActivate
                  ? Color.fromARGB(
                      255,
                      255,
                      203,
                      105,
                    )
                  : Colors.grey,
            ),
          ),
          if (isActivate)
            Container(
              width: text.length * 9.0,
              height: 2,
              color: Color.fromARGB(
                255,
                255,
                203,
                105,
              ),
            )
        ],
      ),
    );
  }
}
