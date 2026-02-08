import 'package:cook_buddy/utils/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final recipeVM = Provider.of<RecipeViewModel>(context);
    final languageVM = Provider.of<LanguageViewModel>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightWhite,
        appBar: AppBar(
          backgroundColor: CustomColors.orange,
          title: Image.asset("assets/photos/name.png", width: width * 0.3),
          actions: [_languageButton(height, width, languageVM)],
        ),
        body: Column(
          children: [
            Expanded(child: _context(recipeVM, languageVM, width, height)),
            _textField(languageVM, width),
            _searchButton(languageVM, recipeVM, width, height),
          ],
        ),
      ),
    );
  }

  Widget _languageButton(
    double height,
    double width,
    LanguageViewModel languageVM,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: GestureDetector(
        onTap: languageVM.toggleLanguage,
        child: Row(
          children: [
            Image.asset("assets/photos/language.png", width: width * 0.08),
            Text(
              languageVM.language == "Hindi" ? "हिन्दी" : "English",
              style: TextStyle(
                fontSize: width * 0.03,
                color: CustomColors.white,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _context(
    RecipeViewModel recipeVM,
    LanguageViewModel languageVM,
    double width,
    double height,
  ) {
    final ingredients =
        languageVM.language == "Hindi"
            ? recipeVM.response.ingredientsHindi
            : recipeVM.response.ingredients;

    final steps =
        languageVM.language == "Hindi"
            ? recipeVM.response.stepsHindi
            : recipeVM.response.steps;

    final dishes =
        languageVM.language == "Hindi"
            ? recipeVM.response.dishListHindi
            : recipeVM.response.dishList;

    if (!recipeVM.isLoading &&
        recipeVM.response.error.isEmpty &&
        recipeVM.response.title.isEmpty &&
        recipeVM.response.dishList.isEmpty) {
      return _welcome(height, width, languageVM);
    } else if (recipeVM.isLoading) {
      return _loading(width, languageVM);
    } else if (recipeVM.response.error.isNotEmpty) {
      return _errorText(recipeVM, languageVM);
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (recipeVM.response.title.isNotEmpty &&
                  recipeVM.response.titleHindi.isNotEmpty)
                _headerSection("Recipe", "रेसिपी", languageVM, width),
              _textSection(
                recipeVM.response.title,
                recipeVM.response.titleHindi,
                languageVM,
                width,
              ),

              if (ingredients.isNotEmpty)
                _headerSection("Ingredients", "सामग्री", languageVM, width),
              _listViewBuilder(ingredients, true),

              if (steps.isNotEmpty)
                _headerSection(
                  "Recipe Steps",
                  "बनाने की विधि",
                  languageVM,
                  width,
                ),
              _listViewBuilder(steps, false),

              if (dishes.isNotEmpty)
                _headerSection(
                  "Suggested Dishes",
                  "सुझाए गए व्यंजन",
                  languageVM,
                  width,
                ),
              _dishesList(dishes),
            ],
          ),
        ),
      );
    }
  }

  Widget _welcome(double height, double width, LanguageViewModel languageVM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.01),
            child: Image.asset("assets/photos/robot.png"),
          ),
        ),
        Text(
          languageVM.language == "Hindi"
              ? "Cook Buddy में आपका स्वागत है!"
              : "Welcome to Cook Buddy!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.06,
            color: CustomColors.orange,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _loading(double width, LanguageViewModel languageVM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Image.asset("assets/photos/robot2.png", width: width * 0.9),
        ),
        Text(
          languageVM.language == "Hindi"
              ? "कृपया प्रतीक्षा करें"
              : "Please Wait!!!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.05,
            color: CustomColors.black,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _headerSection(
    String english,
    String hindi,
    LanguageViewModel languageVM,
    double width,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: width * 0.015),
      child: Text(
        languageVM.language == "Hindi" ? hindi : english,
        style: CustomTextStyle.heading(context: context),
      ),
    );
  }

  Widget _textSection(
    String english,
    String hindi,
    LanguageViewModel languageVM,
    double width,
  ) {
    return Text(
      languageVM.language == "Hindi" ? hindi : english,
      style: CustomTextStyle.heading(context: context),
    );
  }

  Widget _listViewBuilder(List<String> items, bool isBulleted) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBulleted ? '•  ' : '${index + 1}.  ',
              style: CustomTextStyle.description(context: context),
            ),
            Expanded(
              child: Text(
                items[index],
                style: CustomTextStyle.description(context: context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dishesList(List<String> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            _controller.text = items[index];
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${index + 1}. ${items[index]}",
              style: CustomTextStyle.textButton(context: context),
            ),
          ),
        );
      },
    );
  }

  Widget _errorText(RecipeViewModel recipeVM, LanguageViewModel languageVM) {
    return Center(
      child: Text(
        recipeVM.response.error == "Sorry\n"
            ? languageVM.language == "Hindi"
                ? "क्षमा करें, यह वैध रेसिपी क्वेरी नहीं है।"
                : "Sorry, this is not a valid recipe query."
            : recipeVM.response.error,
        style: CustomTextStyle.error(context: context),
      ),
    );
  }

  Widget _textField(LanguageViewModel languageVM, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 5),
      child: TextFormField(
        cursorColor: CustomColors.orange,
        controller: _controller,
        style: TextStyle(color: CustomColors.black, fontSize: width * 0.04),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.orange, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.orange, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          label: Text(
            languageVM.language == "Hindi"
                ? "व्यंजन या सामग्री दर्ज करें"
                : "Enter Dish or Ingredients",
            style: TextStyle(
              color: CustomColors.orange,
              fontSize: width * 0.04,
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchButton(
    LanguageViewModel languageVM,
    RecipeViewModel recipeVM,
    double width,
    double height,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      child: GestureDetector(
        onTap: () {
          if (_controller.text.isEmpty) {
            Fluttertoast.showToast(
              msg:
                  languageVM.language == "Hindi"
                      ? "कृपया व्यंजन का नाम या सामग्री दर्ज करें."
                      : "Please enter a dish name or ingredients.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: CustomColors.red,
              textColor: CustomColors.white,
            );
          } else {
            FocusScope.of(context).unfocus();
            recipeVM.getResponse(_controller.text);
            _controller.text = "";
          }
        },
        child: Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(
            color: CustomColors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              recipeVM.isLoading
                  ? languageVM.language == "Hindi"
                      ? "कृपया प्रतीक्षा करें"
                      : "Please Wait"
                  : languageVM.language == "Hindi"
                  ? "नुस्खा खोजें"
                  : "Search Recipe",
              style: TextStyle(
                color: CustomColors.white,
                fontSize: width * 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
