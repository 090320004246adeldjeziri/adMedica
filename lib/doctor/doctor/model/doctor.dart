class Doctor {
  final String specialiste;
  final String name;
  final String address;
  final String phoneNumber;
  final String url;

  Doctor({required this.phoneNumber,required this.name, required this.address,required this.url,required this.specialiste});

  static final List<Doctor> doctors = [
    Doctor(
      specialiste: "cardiologue",
      name: 'RIYAH khaled',
      address: '"54 RUE 72 Habitant , Ain temouchent , Algerie"',
      phoneNumber: '0664596853',
      
      url: "https://th.bing.com/th/id/R.eeaf6c349dcbd169b8e744e535e1ca3b?rik=mVk4q9XBI8Z4Cg&pid=ImgRaw&r=0"
    ),
    Doctor(
      specialiste: "dentiste",
      name: 'BELGHOMARI KHIR-eddine',
      address: '" RUE 21 juillet , Ain temouchent , Algerie"',
      phoneNumber: '05571226994',
       url : "https://th.bing.com/th/id/OIP.0Tuy6ZksymQqU4fAyR0dtgHaE7?rs=1&pid=ImgDetMain"
    ),
    Doctor(
      specialiste: "pneumo",
      name: 'Dr. Robert Johnson',
      address: 'FX33+QCP, Hassi el Ghella , Ain temouchent , Algerie"',
      phoneNumber: '555-9876',
       url : "https://th.bing.com/th/id/R.f9ad1ab8592be91f303f4a9bd15d02b1?rik=G%2fwtEoo9MfZ%2bmw&pid=ImgRaw&r=0"
    ),
    Doctor(
       specialiste: "Ophtamologie",
      name: 'Dr. Susan Lee',
      address: '"N95, Aïn Témouchent"',
      phoneNumber: '555-1111',
       url : "https://th.bing.com/th/id/R.7a4c506ebc28dbec3c2fd61815a4ce46?rik=YMZvs%2f7QvuTcGQ&riu=http%3a%2f%2fophtalmobelfort.fr%2fwp-content%2fuploads%2f2020%2f10%2fohptalmologiste-doctolis.jpg&ehk=AfSddxVx1kBgDIZ3l3ePqS3bDjqjd4KWn4IOgIO7Xos%3d&risl=&pid=ImgRaw&r=0"
    ),
    Doctor(
       specialiste: "pédiatre",
      name: 'BELDGHEM Kouider',
      address: '"8V68+W35, Aïn Témouchent , Algerie"',
      phoneNumber: '0777535392',
       url : "https://i.enfant.com/1400x787/smart/2019/03/07/24979-pediatre-bebe.jpg"
    ),
   
  ];

}