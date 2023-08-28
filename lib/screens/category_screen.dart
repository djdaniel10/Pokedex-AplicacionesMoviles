import 'package:flutter/material.dart';
import 'package:pokedex/providers/category_provider.dart';
import 'package:pokedex/providers/login_provider.dart';
import 'package:pokedex/widgets/category_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String lastUpdate = 'N/A';

  void updateLastSyncDate(String lastSync) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString("last_sync", lastSync);
  }

  Future<String?> getLastSyncDate() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("last_sync");
  }

  int? getStringLength(String? str) {
    return str?.length;
  }

  @override
  void initState() {
    getLastSyncDate().then((value) => {
          setState(() {
            lastUpdate = value ?? 'N/A';
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false)
                  .initializeCategories();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false).clearList();
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () async {
              await _loginProvider.logout();
              if (_loginProvider.user == null) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        title: Text("Tipos de Pokemon de ${_loginProvider.user?.email?.split('@')[0]}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Card(
                elevation: 10,
                child: Text("Ultima Sicronizacion: $lastUpdate"),
              ),
            ),
          ),
          const Expanded(
            child: CategoryListWidget(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CategoryProvider>(context, listen: false)
              .addCategory('Fire');
          setState(() {
            lastUpdate = DateTime.now().toIso8601String();
            updateLastSyncDate(lastUpdate);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
