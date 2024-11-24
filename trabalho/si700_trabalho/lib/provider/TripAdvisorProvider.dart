import 'dart:convert';

import 'package:si700_trabalho/model/CardContent.dart';
import 'package:si700_trabalho/model/trip/DetailsResponseItem.dart';
import 'package:si700_trabalho/model/trip/SearchResponseItem.dart';
import 'package:si700_trabalho/view/layout/PopularCardLayout.dart';
import 'package:dio/dio.dart';

class Tripadvisorprovider {
  String key = "CE0333CC20B0488B98C99695AC0E67A4";
  static Tripadvisorprovider helper = Tripadvisorprovider._createInstance();

  final Dio _dio = Dio();

  Tripadvisorprovider._createInstance();
  bool MOCK = false;

  String searchMock = '''{
    "data": [
        {
            "location_id": "3419692",
            "name": "Limeira Suítes",
            "address_obj": {
                "street1": "Rua Miguel Guidotti 1295",
                "street2": "",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13485-342",
                "address_string": "Rua Miguel Guidotti 1295, Limeira, Estado de São Paulo 13485-342 Brasil"
            }
        },
        {
            "location_id": "1156967",
            "name": "Nacional Inn Limeira",
            "address_obj": {
                "street1": "Rua Barão de Campinas, 224",
                "street2": "",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13480-210",
                "address_string": "Rua Barão de Campinas, 224, Limeira, Estado de São Paulo 13480-210 Brasil"
            }
        },
        {
            "location_id": "1740485",
            "name": "Fênix Hotel Limeira",
            "address_obj": {
                "street1": "Av. Ismael Ferreira dos Santos, 620",
                "street2": "",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13485-344",
                "address_string": "Av. Ismael Ferreira dos Santos, 620, Limeira, Estado de São Paulo 13485-344 Brasil"
            }
        },
        {
            "location_id": "2000849",
            "name": "Hotel Carlton Suítes Limeira",
            "address_obj": {
                "street1": "Rua Boulevard de la Loi, No 601",
                "street2": "Centreville",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13484-247",
                "address_string": "Rua Boulevard de la Loi, No 601 Centreville, Limeira, Estado de São Paulo 13484-247 Brasil"
            }
        },
        {
            "location_id": "4508799",
            "name": "Pousada Limeira",
            "address_obj": {
                "street1": "Estrada Vargem Bonita à Cachoeira Casca Danta, Km 7",
                "street2": "",
                "city": "Vargem Bonita",
                "state": "Minas Gerais",
                "country": "Brasil",
                "postalcode": "37922-000",
                "address_string": "Estrada Vargem Bonita à Cachoeira Casca Danta, Km 7, Vargem Bonita, Minas Gerais 37922-000 Brasil"
            }
        },
        {
            "location_id": "6717216",
            "name": "Verona Hotel",
            "address_obj": {
                "street1": "Avenida Marechal Arthur da Costa E Silva 812",
                "street2": "",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13487-230",
                "address_string": "Avenida Marechal Arthur da Costa E Silva 812, Limeira, Estado de São Paulo 13487-230 Brasil"
            }
        },
        {
            "location_id": "21361870",
            "name": "Hotel Zahara",
            "address_obj": {
                "street1": "Rua José Jorge Rodrigues, 469",
                "street2": "Vila Nova",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13486-316",
                "address_string": "Rua José Jorge Rodrigues, 469 Vila Nova, Limeira, Estado de São Paulo 13486-316 Brasil"
            }
        },
        {
            "location_id": "2195640",
            "name": "Hotel Limeira",
            "address_obj": {
                "street1": "Ilha de Santiago",
                "street2": "",
                "city": "Cidade Velha",
                "state": "Santiago",
                "country": "Cabo Verde",
                "postalcode": "1234",
                "address_string": "Ilha de Santiago, Cidade Velha, Santiago 1234 Cabo Verde"
            }
        },
        {
            "location_id": "5009564",
            "name": "Plaza Hotel",
            "address_obj": {
                "street1": "Avenida Major Jose Levy Sobrinho 2150",
                "street2": "",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13486-190",
                "address_string": "Avenida Major Jose Levy Sobrinho 2150, Limeira, Estado de São Paulo 13486-190 Brasil"
            }
        },
        {
            "location_id": "10150581",
            "name": "Rius Motel Limeira",
            "address_obj": {
                "street1": "Avenida Major Jose Levy Sobrinho 5467",
                "street2": "",
                "city": "Limeira",
                "state": "Estado de São Paulo",
                "country": "Brasil",
                "postalcode": "13486-190",
                "address_string": "Avenida Major Jose Levy Sobrinho 5467, Limeira, Estado de São Paulo 13486-190 Brasil"
            }
        }
    ]
}''';

  String detailsMock = '''{
    "location_id": "3419692",
    "name": "Limeira Suítes",
    "description": "Descubra por que tantos viajantes escolhem o Limeira Suítes ao visitar Limeira. Com uma mistura perfeita de conforto, preço e conveniência, o local oferece um ambiente econômico, com várias comodidades projetadas especialmente para viajantes como você.O Limeira Suites é um hotel econômico que oferece ar-condicionado e minibar nos quartos, além de wi-fi gratuito para que todos os hóspedes possam usar a internet à vontade.O hotel conta com recepção 24 horas e serviço de quarto. Além disso, os hóspedes podem aproveitar a banheira de hidromassagem e o restaurante, o que faz desse hotel uma opção popular entre as pessoas que visitam Limeira. Para hóspedes com carro, há estacionamento grátis.Quem conhecer pontos turísticos famosos ao visitar Limeira, vai gostar de saber que o Limeira Suites fica bem perto de lugares como Limeirão (2,0 km) e Categral Nossa Senhora das Dores (2,1 km).Em Limeira, confira alguns restaurantes que ficam bem perto do Limeira Suites, incluindo Restaurante Jangada (0,2 km) e Churrascaria Rei dos Pampas (0,2 km).Não faltam coisas interessantes para fazer na área: conheça belos jardins, como Praça Dr. Luciano Esteves.Aproveite sua estadia no Limeira Suítes para experimentar tudo o que Limeira tem a oferecer.",
    "web_url": "https://www.tripadvisor.com.br/Hotel_Review-g303617-d3419692-Reviews-Limeira_Suites-Limeira_State_of_Sao_Paulo.html?m=66827",
    "address_obj": {
        "street1": "Rua Miguel Guidotti 1295",
        "street2": "",
        "city": "Limeira",
        "state": "Estado de São Paulo",
        "country": "Brasil",
        "postalcode": "13485-342",
        "address_string": "Rua Miguel Guidotti 1295, Limeira, Estado de São Paulo 13485-342 Brasil"
    },
    "ancestors": [
        {
            "level": "City",
            "name": "Limeira",
            "location_id": "303617"
        },
        {
            "abbrv": "SP",
            "level": "State",
            "name": "Estado de São Paulo",
            "location_id": "303598"
        },
        {
            "level": "Country",
            "name": "Brasil",
            "location_id": "294280"
        }
    ],
    "latitude": "-22.536469",
    "longitude": "-47.383266",
    "timezone": "America/Sao_Paulo",
    "write_review": "https://www.tripadvisor.com.br/UserReview-g303617-d3419692-Limeira_Suites-Limeira_State_of_Sao_Paulo.html?m=66827",
    "ranking_data": {
        "geo_location_id": "303617",
        "ranking_string": "Nº 1 de 12 hotéis em Limeira",
        "geo_location_name": "Limeira",
        "ranking_out_of": "12",
        "ranking": "1"
    },
    "rating": "4.0",
    "rating_image_url": "https://www.tripadvisor.com.br/img/cdsi/img2/ratings/traveler/4.0-66827-5.svg",
    "num_reviews": "222",
    "review_rating_count": {
        "1": "10",
        "2": "10",
        "3": "47",
        "4": "89",
        "5": "66"
    },
    "subratings": {
        "0": {
            "name": "rate_location",
            "localized_name": "Localização",
            "rating_image_url": "https://static.tacdn.com/img2/ratings/traveler/ss4.0.svg",
            "value": "4.0"
        },
        "1": {
            "name": "rate_sleep",
            "localized_name": "Sono",
            "rating_image_url": "https://static.tacdn.com/img2/ratings/traveler/ss4.0.svg",
            "value": "4.0"
        },
        "2": {
            "name": "rate_room",
            "localized_name": "Quartos",
            "rating_image_url": "https://static.tacdn.com/img2/ratings/traveler/ss4.0.svg",
            "value": "4.0"
        },
        "3": {
            "name": "rate_service",
            "localized_name": "Atendimento",
            "rating_image_url": "https://static.tacdn.com/img2/ratings/traveler/ss4.0.svg",
            "value": "4.0"
        },
        "4": {
            "name": "rate_value",
            "localized_name": "Custo",
            "rating_image_url": "https://static.tacdn.com/img2/ratings/traveler/ss4.0.svg",
            "value": "4.0"
        },
        "5": {
            "name": "rate_cleanliness",
            "localized_name": "Limpeza",
            "rating_image_url": "https://static.tacdn.com/img2/ratings/traveler/ss4.0.svg",
            "value": "4.0"
        }
    },
    "photo_count": "93",
    "see_all_photos": "https://www.tripadvisor.com.br/Hotel_Review-g303617-d3419692-m66827-Reviews-Limeira_Suites-Limeira_State_of_Sao_Paulo.html#photos",
    "amenities": [
        "Internet",
        "Internet gratuita",
        "Wi-fi",
        "Wi-fi gratuito",
        "Suítes",
        "Estacionamento gratuito",
        "Acesso para cadeirante",
        "Restaurante",
        "Café da manhã",
        "Salas de reunião",
        "Quartos para não fumantes",
        "Ar-condicionado",
        "Quartos para família",
        "Quartos acessíveis",
        "Geladeira no quarto",
        "Minibar",
        "TV de tela plana",
        "Bufê de café da manhã",
        "Serviço de limpeza",
        "Recepção 24 horas",
        "Estacionamento seguro",
        "Serviço de quarto",
        "Wi-fi pública",
        "Serviço de lavanderia",
        "Cofre",
        "Sauna",
        "Inglês",
        "Português",
        "Máquinas de venda automática"
    ],
    "category": {
        "name": "hotel",
        "localized_name": "Hotel"
    },
    "subcategory": [
        {
            "name": "hotel",
            "localized_name": "Hotel"
        }
    ],
    "styles": [
        "Executivo",
        "Para família"
    ],
    "neighborhood_info": [],
    "trip_types": [
        {
            "name": "business",
            "localized_name": "Negócios",
            "value": "116"
        },
        {
            "name": "couples",
            "localized_name": "Romântica",
            "value": "15"
        },
        {
            "name": "solo",
            "localized_name": "Viagem individual",
            "value": "12"
        },
        {
            "name": "family",
            "localized_name": "Família",
            "value": "46"
        },
        {
            "name": "friends",
            "localized_name": "Viagem com amigos",
            "value": "10"
        }
    ],
    "awards": []
}''';

  String photoMock = '''{
    "data": [
        {
            "id": 285350756,
            "is_blessed": false,
            "caption": "Suite Master",
            "published_date": "2017-10-18T18:19:06.05Z",
            "images": {
                "thumbnail": {
                    "height": 50,
                    "width": 50,
                    "url": "https://media-cdn.tripadvisor.com/media/photo-t/11/02/1b/64/suite-master.jpg"
                },
                "small": {
                    "height": 150,
                    "width": 150,
                    "url": "https://media-cdn.tripadvisor.com/media/photo-l/11/02/1b/64/suite-master.jpg"
                },
                "medium": {
                    "height": 165,
                    "width": 250,
                    "url": "https://media-cdn.tripadvisor.com/media/photo-f/11/02/1b/64/suite-master.jpg"
                },
                "large": {
                    "height": 364,
                    "width": 550,
                    "url": "https://media-cdn.tripadvisor.com/media/photo-s/11/02/1b/64/suite-master.jpg"
                },
                "original": {
                    "height": 424,
                    "width": 640,
                    "url": "https://media-cdn.tripadvisor.com/media/photo-o/11/02/1b/64/suite-master.jpg"
                }
            },
            "album": "Quarto/suíte",
            "source": {
                "name": "Management",
                "localized_name": "Gerência"
            },
            "user": {
                "username": "Gerência"
            }
        }
    ]
}''';

  Future<List<PopularCardLayout>> search(String searchQuery) async {
    Response response;

    if (MOCK) {
      response = Response(requestOptions: RequestOptions(), data: searchMock);
    } else {
      response = await _dio.get(
          "https://76accd79-8533-49a8-b646-ad9964777fd5-00-r8io3xj4d2eo.spock.replit.dev/search?searchQuery=$searchQuery");
    }

    List<SearchResponseItem> searchResponse = [];

    response.data["data"].forEach((element) {
      searchResponse.add(SearchResponseItem.fromJson(element));
    });

    List<PopularCardLayout> cards = [];

    for (var element in searchResponse) {
      cards.add(PopularCardLayout(
          cardContent: CardContent.fromSearchResponseItem(element)));
    }

    return cards;
  }

  Future<List<PopularCardLayout>> getPopularList() async {
    return search("Limeira");
  }

  Future<String> getPhoto(String locationId) async {
    Response response;

    if (MOCK) {
      response = Response(requestOptions: RequestOptions(), data: photoMock);
    } else {
      response = await _dio.get<String>(
        "https://76accd79-8533-49a8-b646-ad9964777fd5-00-r8io3xj4d2eo.spock.replit.dev/photos?locationId=$locationId",
      );
    }
    return jsonDecode(response.data)["data"][0]["images"]["original"]["url"];
  }

  Future<CardContent> getDetails(
      String locationId, CardContent? cardContent) async {
    Response response;

    if (MOCK) {
      response = Response(requestOptions: RequestOptions(), data: detailsMock);
    } else {
      response = await _dio.get<String>(
        "https://76accd79-8533-49a8-b646-ad9964777fd5-00-r8io3xj4d2eo.spock.replit.dev/details?locationId=$locationId",
      );
    }

    var decode = jsonDecode(response.data);

    DetailsResponseItem detailsResponse = DetailsResponseItem.fromJson(decode);

    cardContent ??=
        CardContent.fromSearchResponseItem(SearchResponseItem.fromJson(decode));

    cardContent!.fullDescription = detailsResponse.description;
    cardContent.rating = detailsResponse.rating;
    cardContent.webUrl = detailsResponse.webUrl;
    cardContent.setImgUrl(await getPhoto(locationId));

    return cardContent;
  }
}
