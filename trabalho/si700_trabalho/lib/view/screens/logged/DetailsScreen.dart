import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si700_trabalho/bloc/TravelBloc.dart';
import 'package:si700_trabalho/bloc/TravelDetailsBloc.dart';
import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/model/ProfileContent.dart';
import 'package:si700_trabalho/view/layout/text/BaseTextLayout.dart';

class DetailsScreen extends StatelessWidget {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    CardContent.lastSelected!.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 260), // Espaço para a imagem
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título e ícone de usuário
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Niladri Reservoir',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tekergat, Sunamgnj',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/profile.png'), // Ícone de perfil
                            radius: 25,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Localização e classificação
                      Row(
                        children: const [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 5),
                          Text('Tekergat'),
                          SizedBox(width: 20),
                          Icon(Icons.star, color: Colors.amber),
                          SizedBox(width: 5),
                          Text('4.7 (2498)',
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 20),
                          Text(
                            '\$59/Pessoa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Galeria de imagens
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildGalleryItem('assets/img1.png'),
                            _buildGalleryItem('assets/img2.png'),
                            _buildGalleryItem('assets/img3.png'),
                            _buildGalleryItem('assets/img4.png'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Descrição do destino
                      Text(
                        'Sobre o Destino',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Você receberá um pacote de viagem completo nas praias. Pacotes nas '
                        'formações de passagens aéreas, quartos de hotel recomendados...'
                        'Leia mais',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<TravelDetailsBloc, TravelDetailsState>(
                        bloc: TravelDetailsBloc.instance,
                        builder: (context, state) {
                          switch (state) {
                            case TravelDetailsState.Idle:
                              return Center(
                                child: Column(children: [
                                  TextField(
                                    controller: _startDateController,
                                    decoration: InputDecoration(
                                      hintText: '01/01/2024',
                                      labelText: 'Data de início da reserva',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: _endDateController,
                                    decoration: InputDecoration(
                                      hintText: '31/12/2024',
                                      labelText: 'Data de fim da reserva',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // TODO FAZER ALGUMA COISA COM O _endDateController E O _startDateController
                                      TravelDetailsBloc.instance.add(
                                          TravelDetailsEvent.ReserveFinished);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 80, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      'Reservar',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ]),
                              );
                            case TravelDetailsState.ReserveFinished:
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Mensagem de agradecimento
                                    Text(
                                      'Obrigado por sua reserva, ${ProfileContent.self!.name} !',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Te esperamos lá!',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 40),
                                    ElevatedButton(
                                      onPressed: () {
                                        TravelDetailsBloc.instance
                                            .add(TravelDetailsEvent.Idle);
                                        TravelBloc.instance
                                            .add(TravelEvent.Idle);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 80, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: BaseTextLayout(text: 'Até lá!'),
                                    ),
                                  ],
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => TravelBloc.instance.add(TravelEvent.Idle),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite_border, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
