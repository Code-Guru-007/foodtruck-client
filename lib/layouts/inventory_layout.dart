import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/services/inventories_service.dart';
import 'package:treatlab_new/widgets/expansion_widget.dart';

class InventoryLayout extends StatefulWidget {
  final Pages page;

  const InventoryLayout({
    super.key,
    required this.page,
  });

  @override
  State<InventoryLayout> createState() => _InventoryLayoutState();
}

class _InventoryLayoutState extends State<InventoryLayout> {
  int selected = 1;
  bool isLoading = true;
  List inventories = [];

  @override
  void initState() {
    super.initState();
    fetchInventories();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: fetchInventories,
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
                          (states) => Colors.white,
                        ),
                        surfaceTintColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFFFFF4E7),
                        ),
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white,
                        ),
                        shadowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent,
                        ),
                        leading: const Icon(Icons.search),
                        shape: MaterialStateProperty.all(
                          const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            side: BorderSide(width: 0.2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: inventories.length,
                        itemBuilder: (context, index) {
                          final inventory = inventories[index] as Map;
                          return ListTile(
                            title: Text(inventory['Ingredient']),
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
                          );
                        },
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
                    children: inventories.isEmpty
                        ? [
                            const Center(
                              child: Text(
                                "No orders available",
                                style: TextStyle(
                                  fontSize: 20,
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
                                    deleteById(inventories[selected]['_id']);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppColor.primary.color,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
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
                              decoration: const BoxDecoration(
                                  border:
                                      Border(bottom: BorderSide(width: 0.1))),
                              child: Row(
                                children: [
                                  Text(
                                    inventories[selected]['Ingredient'],
                                    style: const TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      ExpansionWidget(
                                        title: "Unit",
                                        trailingIcon:
                                            const Icon(Icons.edit, size: 14),
                                        onTrailingActionStarted: () {},
                                        children: const [
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Kilogram"),
                                                Text("kg"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 35),
                                      ExpansionWidget(
                                        title: "Types",
                                        trailingIcon:
                                            const Icon(Icons.add, size: 14),
                                        onTrailingActionStarted:
                                            onAddIngredientType,
                                        children: inventories.map<Widget>(
                                          (inventory) {
                                            return Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Frozen"),
                                                  TextButton(
                                                    onPressed: () {},
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: AppColor
                                                          .primary.color,
                                                      foregroundColor:
                                                          Colors.white,
                                                      // minimumSize: const Size(88, 28),
                                                      // fixedSize: const Size.fromHeight(28),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.delete,
                                                            size: 11),
                                                        SizedBox(
                                                            width: 8,
                                                            height: 12),
                                                        Text("Delete",
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                height: 0))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                )
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

  void onAddStorage() {}

  void onEditUnit() {}

  void onAddIngredientType() {}

  Future<void> fetchInventories() async {
    setState(() {
      isLoading = true;
    });

    final response = await InventoriesService.fetchGetAllInventories();

    if (response != null) {
      setState(() {
        inventories = response;
      });
    } else {
      // print('Get Failed');
      // showErrorMessage(context, message: 'Get Failed');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await InventoriesService.deleteById(id);
    if (isSuccess) {
      final filtered =
          inventories.where((element) => element['_id'] != id).toList();
      setState(() {
        isLoading = true;
        inventories = filtered;
        fetchInventories();
      });
    } else {
      // print('Delete Failed');
    }
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
