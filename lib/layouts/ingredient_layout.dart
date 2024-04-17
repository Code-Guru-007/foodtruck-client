import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/services/ingredients_service.dart';
import 'package:treatlab_new/services/measurement_units_service.dart';
import 'package:treatlab_new/widgets/expansion_widget.dart';

class IngredientLayout extends StatefulWidget {
  final Pages page;
  const IngredientLayout({super.key, required this.page});

  @override
  State<IngredientLayout> createState() => _IngredientLayoutState();
}

class _IngredientLayoutState extends State<IngredientLayout> {
  bool isLoading = true;
  bool isUpdateEnabled = false;
  int selected = 0;
  List ingredients = [];
  List measurementUnit = [];
  String selectedMeasurementUnit = '';
  bool isEditingTitle = false;
  final List<dynamic> testlist = [
    {
      'id': 1,
      'storageLocation': {'name': 'Fridge'}
    },
    {
      'id': 2,
      'storageLocation': {'name': 'Pantry'}
    },
    {
      'id': 3,
      'storageLocation': {'name': 'Freezer'}
    },
  ];
  List<dynamic> selectedTestlist = [];
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: fetchIngredients,
        child: SizedBox.expand(
          child: Row(
            children: [
              Container(
                width: 450,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      height: 45,
                      child: SearchBar(
                        hintText: "Search by name, editor or date",
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        surfaceTintColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFFFFF4E7)),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                        leading: const Icon(Icons.search),
                        shape: MaterialStateProperty.all(
                            const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                side: BorderSide(width: 0.2))),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showAddIngredientDialog(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green, // Use a suitable color
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Row(
                        children: [
                          Icon(Icons.add, size: 14),
                          SizedBox(width: 8),
                          Text("Add New")
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ListView.separated(
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) => ListTile(
                          // leading: Image.asset("assets/burger.jpg", width: 85, fit: BoxFit.cover),
                          title: Text(ingredients[index]['name']),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          textColor: Colors.black87,
                          tileColor: Colors.white,
                          splashColor: const Color(0xFFEBEBEB),
                          selected: (index == selected),
                          selectedColor: AppColor.primary.color,
                          selectedTileColor: const Color(0xFFEBEBEB),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          onTap: () => {
                            setState(() {
                              selected = index;
                            })
                          },
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          thickness: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: ingredients.isEmpty
                      ? const Center(
                          child: Text(
                            "Not Selected Ingredients",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              buttonHeight: 45,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: AppColor.woody.color,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.edit, size: 14),
                                      SizedBox(width: 8),
                                      Text("Update")
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteById(ingredients[selected]['_id']);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppColor.primary.color,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.delete, size: 14),
                                      SizedBox(width: 8),
                                      Text("Delete")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              child: Row(
                                children: [
                                  (!isEditingTitle)
                                      ? Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                ingredients.isNotEmpty
                                                    ? ingredients[selected]
                                                            ['name'] ??
                                                        ''
                                                    : '',
                                                style: const TextStyle(
                                                  fontFamily: "Times New Roman",
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 14,
                                                ),
                                                onPressed: onEditTitle,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                        controller:
                                                            _titleController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    'Enter title')),
                                                  ),
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.save),
                                                    onPressed: onSaveTitle,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    onPressed: onCancelTitle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ExpansionWidget(
                                            title: "Measurement Unit",
                                            trailingIcon:
                                                const Icon(Icons.add, size: 14),
                                            onTrailingActionStarted: () {},
                                            children: [
                                              DropdownButtonFormField<String>(
                                                value: ingredients[selected]
                                                    ['measurementUnit']['_id'],
                                                decoration: InputDecoration(
                                                  labelText: "Select Unit",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10,
                                                          horizontal: 14),
                                                ),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    ingredients[selected]
                                                            ['measurementUnit']
                                                        ['_id'] = value;
                                                  });
                                                },
                                                items: measurementUnit.map<
                                                    DropdownMenuItem<String>>(
                                                  (unit) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: unit['_id'],
                                                      child: Text(unit['name']),
                                                    );
                                                  },
                                                ).toList(),
                                                icon: const Icon(Icons
                                                    .arrow_drop_down_circle),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 35),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                // Second row with Types and Storage Locations
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: MultiSelectDialogField(
                                      items: ingredients
                                          .map((ingredient) => MultiSelectItem(
                                              ingredient,
                                              ingredient['storageLocation']
                                                  ['name']))
                                          .toList(),
                                      title: const Text("Select Types"),
                                      buttonIcon: const Icon(Icons.add),
                                      buttonText: const Text("Select Types"),
                                      onConfirm: (results) {
                                        // Handle selection confirmation
                                      },
                                    )),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: MultiSelectDialogField(
                                        items: ingredients
                                            .map((ingredient) =>
                                                MultiSelectItem(
                                                    ingredient,
                                                    ingredient[
                                                            'storageLocation']
                                                        ['name']))
                                            .toList(),
                                        title: const Text("Storage Locations"),
                                        buttonIcon: const Icon(Icons.add),
                                        buttonText: const Text(
                                            "Select Storage Locations"),
                                        onConfirm: (results) {
                                          // Handle selection confirmation
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  void onEditTitle() {
    setState(() {
      isEditingTitle = !isEditingTitle;
    });
    if (ingredients.isNotEmpty &&
        selected >= 0 &&
        selected < ingredients.length) {
      _titleController.value = _titleController.value.copyWith(
        text: ingredients[selected]['name'] ?? '',
        selection: TextSelection.collapsed(
            offset: (ingredients[selected]['name'] ?? '').length),
      );
    }
  }

  void onSaveTitle() {
    setState(() {
      isEditingTitle = false;
      isUpdateEnabled = true;
      ingredients[selected]['name'] = _titleController.text;
    });
  }

  void onCancelTitle() {
    setState(() {
      isEditingTitle = false;
    });
  }

  void onAddStorage() {}

  void onEditUnit() {}

  void onAddIngredientType() {}

  void onDeleteIngredientInfo() {}

  void showAddIngredientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Ingredient"),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 450,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: 300,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(hintText: "Enter title"),
                    controller: _titleController,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Select Unit",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        ingredients[selected]['measurementUnit']['_id'] = value;
                      });
                    },
                    items: measurementUnit.map<DropdownMenuItem<String>>(
                      (unit) {
                        return DropdownMenuItem<String>(
                          value: unit['_id'],
                          child: Text(unit['name']),
                        );
                      },
                    ).toList(),
                    icon: const Icon(Icons.arrow_drop_down_circle),
                  ),
                  const SizedBox(height: 20),
                  MultiSelectDialogField(
                    items: ingredients
                        .map((ingredient) => MultiSelectItem(
                            ingredient, ingredient['storageLocation']['name']))
                        .toList(),
                    title: const Text("Storage Locations"),
                    buttonIcon: const Icon(Icons.add),
                    buttonText: const Text("Select Storage Locations"),
                    onConfirm: (results) {
                      // Handle selection confirmation
                    },
                  ),
                  const SizedBox(height: 20),
                  MultiSelectDialogField(
                    items: ingredients
                        .map((ingredient) => MultiSelectItem(
                            ingredient, ingredient['storageLocation']['name']))
                        .toList(),
                    title: const Text("Storage Locations"),
                    buttonIcon: const Icon(Icons.add),
                    buttonText: const Text("Select Storage Locations"),
                    onConfirm: (results) {
                      // Handle selection confirmation
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                // Logic to save the new ingredient
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchIngredients() async {
    setState(() {
      isLoading = true;
    });

    final response = await IngredientsService.fetchGetAllIngredients();

    if (response != null) {
      setState(() {
        ingredients = response;
      });
      final unitresponse =
          await MeasurementUnitsService.fetchMeasurementUnits();
      if (unitresponse != null) {
        setState(() {
          measurementUnit = unitresponse;
        });
      }
    } else {
      // print('Get Failed');
      // showErrorMessage(context, message: 'Get Failed');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await IngredientsService.deleteById(id);
    if (isSuccess) {
      final filtered =
          ingredients.where((element) => element['_id'] != id).toList();
      setState(() {
        ingredients = filtered;
        if (selected >= ingredients.length) {
          selected = ingredients.isEmpty ? 0 : ingredients.length - 1;
        }
      });
    } else {
      // print('Delete Failed');
    }
  }
}
