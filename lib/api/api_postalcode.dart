import 'package:dio/dio.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repository/api_error.dart';
import 'package:xlo/repository/api_response.dart';

Future<APIResponse> getAdressFromAPI(String postalCode) async {
  final String endpoint =
      "http://www.viacep.com.br/ws/${postalCode.replaceAll(".", "").replaceAll("-", "")}/json/";

  try {
    final Response response = await Dio().get<Map>(endpoint);

    if (response.data.containsKey("erro") && response.data["erro"]) {
      return APIResponse.error(error: ApiError(code: -1, message: "CEP Inválido"));
    }

    final Address address = Address(
      place: response.data["logradouro"],
      district: response.data["bairro"],
      city: response.data["localidade"],
      postalCode: response.data["cep"],
      federativeUnit: response.data["uf"],
    );

    return APIResponse.success(
      result: address
    );
  } on DioError catch (e) {
    return APIResponse.error(error: ApiError(code: -1, message: "Falha ao consultar VIACEP"));
    print(e.message);
  }
}
