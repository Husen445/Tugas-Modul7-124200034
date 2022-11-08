import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'countries_model.dart';
import 'covid_data_source.dart';
class PagelistCountries extends StatefulWidget {
  const PagelistCountries({Key? key}) : super(key: key);
  @override
  _PagelistCountriesState createState() => _PagelistCountriesState();
}
class _PagelistCountriesState extends State<PagelistCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card List Countries"),
      ),
      body: _buildlistCountriesBody(),
    );
  }
  Widget _buildlistCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
            CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }
  Widget _buildErrorSection() {
    return Text("Error");
  }
  Widget _buildEmptySection() {
    return Text("Empty");
  }
  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _buildSuccessSection(CountriesModel data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: data.countries?.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.red,
          child: Center(
            child: Text(
              "${data.countries?[index].name}\n\n"
                  "(${data.countries?[index].iso3})",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}