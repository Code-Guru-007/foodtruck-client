import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/services/dishes_service.dart';
import 'package:treatlab_new/widgets/expansion_widget.dart';
import 'package:treatlab_new/widgets/search_widget.dart';

class DishLayout extends StatefulWidget {
  final Pages page;

  const DishLayout({super.key, required this.page});

  @override
  State<DishLayout> createState() => _DishLayoutState();
}

class _DishLayoutState extends State<DishLayout> {
  bool isLoading = true;
  bool isEditingDescription = false;
  bool isEditingIngredients = false;
  bool isUpdateEnabled = false;
  bool isEditingTitle = false;

  int selected = 0;

  List dishes = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: fetchDishes,
        child: SizedBox.expand(
          child: Row(
            children: [
              Container(
                width: 450,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      height: 45,
                      child: SearchWidget(
                        hintText: "Search by name, editor or date",
                        onSearch: onSearch,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: dishes.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: Image.asset("assets/burger.jpg",
                              width: 78, fit: BoxFit.cover),
                          title: Text(dishes[index]['Name'] ?? ''),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          textColor: Colors.black87,
                          tileColor: Colors.white,
                          splashColor: const Color(0xFFEBEBEB),
                          selected: (index == selected),
                          selectedColor: AppColor.primary.color,
                          selectedTileColor: const Color(0xFFEBEBEB),
                          contentPadding: const EdgeInsets.all(0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dishes.isEmpty
                        ? [
                            const Center(
                              child: Text(
                                "Not Selected Dishes",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showAddIngredientDialog(context);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Colors.green, // Use a suitable color
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
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
                          ]
                        : [
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              buttonHeight: 45,
                              children: [
                                TextButton(
                                  onPressed:
                                      isUpdateEnabled ? fetchUpdateDish : null,
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: AppColor.woody.color,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.edit, size: 14),
                                      SizedBox(width: 8),
                                      Text("Update"),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    fetchDeleteById(dishes[selected]['_id']);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColor.primary.color,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.delete, size: 14),
                                      SizedBox(width: 8),
                                      Text("Delete"),
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
                                                dishes.isNotEmpty
                                                    ? dishes[selected]
                                                            ['Name'] ??
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
                            Container(
                              width: 240,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              child: FlutterCarousel(
                                options: CarouselOptions(
                                  height: 120.0,
                                  showIndicator: true,
                                  slideIndicator:
                                      const CircularSlideIndicator(),
                                ),
                                items: [1, 2, 3, 4, 5].map((i) {
                                  return Builder(
                                    builder: (context) => Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: AppColor.pinky.color,
                                      ),
                                      child: Image.asset(
                                        "assets/burger.jpg",
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.1)),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "updated on ${formatTimestamp(dishes.isNotEmpty ? dishes[selected]['updatedAt'] ?? '' : '')}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  const Text(
                                    " by Robby Rob",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ExpansionWidget(
                              title: "Description",
                              trailingIcon: const Icon(Icons.edit, size: 14),
                              onTrailingActionStarted: onEditDescription,
                              children: [
                                (!isEditingDescription)
                                    ? Text(
                                        dishes.isNotEmpty
                                            ? dishes[selected]['Description'] ??
                                                ''
                                            : '',
                                      )
                                    : Column(
                                        children: [
                                          TextField(
                                            maxLines: null,
                                            controller: _descriptionController,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            cursorColor: AppColor.linky.color,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Enter description here',
                                              contentPadding:
                                                  const EdgeInsets.all(7),
                                              border: OutlineInputBorder(
                                                gapPadding: 0,
                                                borderSide: BorderSide(
                                                  color: AppColor.border.color,
                                                  width: 0.2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                gapPadding: 0,
                                                borderSide: BorderSide(
                                                  color: AppColor.linky.color,
                                                  width: 0.2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () =>
                                                    onSaveDescription(),
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.woody.color,
                                                  foregroundColor: Colors.black,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.save, size: 14),
                                                    SizedBox(width: 8),
                                                    Text("Save"),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              TextButton(
                                                onPressed:
                                                    onCancelDescription, // onCancelDescription(selected)
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.darky.color,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.close, size: 14),
                                                    SizedBox(width: 8),
                                                    Text("Cancel"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                            ExpansionWidget(
                              title: "Ingredients",
                              trailingIcon: const Icon(Icons.edit, size: 14),
                              onTrailingActionStarted: onEditIngredients,
                              children: [
                                ...(dishes.isNotEmpty
                                        ? dishes[selected]['Ingredients'] ?? []
                                        : [])
                                    .map<Widget>(
                                  (ingredient) {
                                    return Builder(
                                      builder: (context) => SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(ingredient['Name'] ?? ''),
                                            (!isEditingIngredients)
                                                ? Text(
                                                    "${ingredient['QtyDish']} ${ingredient['Unit']}",
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                          "${ingredient['QtyDish']} ${ingredient['Unit']}"),
                                                      const SizedBox(width: 16),
                                                      TextButton(
                                                        onPressed: () =>
                                                            onDeleteIngredient(
                                                                ingredient[
                                                                    'Name']),
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .darky.color,
                                                          foregroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                            Icons.delete,
                                                            size: 14),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
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

  void onSearch(String key) {}

  void onEditDescription() {
    setState(() {
      isEditingDescription = !isEditingDescription;
    });
    if (dishes.isNotEmpty && selected >= 0 && selected < dishes.length) {
      _descriptionController.value = _descriptionController.value.copyWith(
        text: dishes[selected]['Description'] ?? '',
        selection: TextSelection.collapsed(
            offset: (dishes[selected]['Description'] ?? '').length),
      );
    }
  }

  void onEditTitle() {
    setState(() {
      isEditingTitle = !isEditingTitle;
    });
    if (dishes.isNotEmpty && selected >= 0 && selected < dishes.length) {
      _titleController.value = _titleController.value.copyWith(
        text: dishes[selected]['Name'] ?? '',
        selection: TextSelection.collapsed(
            offset: (dishes[selected]['Name'] ?? '').length),
      );
    }
  }

  void onSaveTitle() {
    setState(() {
      isEditingTitle = false;
      isUpdateEnabled = true;
      dishes[selected]['Name'] = _titleController.text;
    });
  }

  void onCancelTitle() {
    setState(() {
      isEditingTitle = false;
    });
  }

  void onSaveDescription() {
    setState(() {
      isEditingDescription = false;
      isUpdateEnabled = true;
      dishes[selected]['Description'] = _descriptionController.text;
    });
  }

  void onCancelDescription() {
    setState(() {
      isEditingDescription = false;
    });
  }

  void onListSelected(int index) {
    setState(() {
      selected = index;
      isEditingDescription = false;
      isEditingIngredients = false;
      if (dishes.isNotEmpty && selected >= 0 && selected < dishes.length) {
        _descriptionController.value = _descriptionController.value.copyWith(
          text: dishes[selected]['Description'] ?? '',
          selection: TextSelection.collapsed(
              offset: (dishes[selected]['Description'] ?? '').length),
        );
      }
    });
  }

  void onEditIngredients() {
    setState(() {
      isEditingIngredients = !isEditingIngredients;
    });
  }

  void onDeleteIngredient(String name) {
    setState(() {
      dishes[selected]['Ingredients']
          .removeWhere((ingredient) => ingredient['Name'] == name);
      isUpdateEnabled = true;
    });
  }

  Future<void> fetchDishes() async {
    setState(() {
      isLoading = true;
    });

    final response = await DishesService.fetchGetAllDishes();

    if (response != null) {
      setState(() {
        dishes = response;
      });
    } else {}

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchUpdateDish() async {
    final isSuccess = await DishesService.updateDish(dishes, selected);
    if (isSuccess) {
      setState(() {
        isLoading = true;
        isUpdateEnabled = false;
        fetchDishes();
      });
    } else {}
  }

  Future<void> fetchDeleteById(String id) async {
    final isSuccess = await DishesService.deleteById(id);
    if (isSuccess) {
      final filtered = dishes.where((element) => element['_id'] != id).toList();
      setState(() {
        isLoading = true;
        dishes = filtered;
        fetchDishes();
      });
    } else {}
  }

  void showAddIngredientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Ingredient"),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 450,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: 300,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: "Enter title"),
                    // controller: _titleController,
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
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
}
