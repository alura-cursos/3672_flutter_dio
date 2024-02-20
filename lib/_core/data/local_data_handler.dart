import 'package:drift/drift.dart';
import 'package:flutter_listin/listins/data/database.dart';
import 'package:flutter_listin/products/data/products_box_handler.dart';
import '../../listins/models/listin.dart';
import '../../products/model/product.dart';

class LocalDataHandler {
  Future<Map<String, dynamic>> localDataToMap({
    required AppDatabase appdatabase,
  }) async {
    // Obtém todos os Listins salvos
    List<Listin> listListins = await appdatabase.getListins();

    // Converte de uma lista de Listins para uma lista de Map
    List<Map<String, dynamic>> listMappedListins =
        listListins.map((listin) => listin.toMap()).toList();

    // Para cada Listin, adicionará uma chave "products" que terá uma lista de produtos
    for (var mappedListin in listMappedListins) {
      // Abre a caixa do Hive do Listin atual
      ProductsBoxHandler pbh = ProductsBoxHandler();
      await pbh.openBox(mappedListin["id"]);

      // Obtém todos os produtos do Listin atual
      List<Product> listProducts = pbh.getProducts();
      List<Map<String, dynamic>> listMappedProducts =
          listProducts.map((product) => product.toMap()).toList();

      // Adiciona nova chave contendo os produtos
      mappedListin["products"] = listMappedProducts;

      // Fecha a caixa do Hive
      await pbh.closeBox();
    }

    // Cria o map "pai" que conterá todas as informações
    Map<String, dynamic> finalMap = {};
    finalMap["listins"] = listMappedListins;

    // Devolve o resultado
    return finalMap;
  }

  Future<void> mapToLocalData({
    required Map<String, dynamic> map,
    required AppDatabase appdatabase,
  }) async {
    await appdatabase.listinTable.deleteAll();

    for (Map<String, dynamic> mappedListin in map["listins"]) {
      // Atualiza o Listin no Drift
      Listin listin = Listin.fromMap(mappedListin);
      int id = await appdatabase.insertListin(listin);

      // Abre a caixa do Hive do Listin atual
      ProductsBoxHandler productsBoxHandler = ProductsBoxHandler();
      await productsBoxHandler.openBox(id.toString());

      // Se houver produtos para adicionar, adiciona.
      if (mappedListin["products"] != null) {
        for (Map<String, dynamic> mappedProduct in mappedListin["products"]) {
          Product product = Product.fromMap(mappedProduct);
          await productsBoxHandler.addProduct(product);
        }
      }
      // Fecha a caixa do Hive
      await productsBoxHandler.closeBox();
    }
  }
}
