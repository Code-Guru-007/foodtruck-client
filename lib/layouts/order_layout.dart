import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/services/orders_service.dart';
import 'package:treatlab_new/widgets/expansion_widget.dart';
import 'package:treatlab_new/widgets/search_widget.dart';

class OrderLayout extends StatefulWidget {
  final Pages page;

  const OrderLayout({
    super.key,
    required this.page,
  });

  @override
  State<OrderLayout> createState() => _OrderLayoutState();
}

class _OrderLayoutState extends State<OrderLayout> {
  bool isLoading = true;
  bool isUpdateEnabled = false;
  bool isEditingTitle = false;
  int selected = 0;
  List orders = [];

  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: fetchOrders,
        child: SizedBox.expand(
          child: Row(
            children: [
              Container(
                width: 450,
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey))),
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
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order['Name']),
                                Text(order['Unit'].toString(),
                                    style: const TextStyle(fontSize: 12)),
                                Text(formatTimestamp(order['createdAt']),
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            textColor: Colors.black87,
                            tileColor: Colors.white,
                            splashColor: const Color(0xFFEBEBEB),
                            selected: (index == selected),
                            selectedColor: AppColor.primary.color,
                            selectedTileColor: const Color(0xFFEBEBEB),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            onTap: () {
                              setState(() {
                                selected = index;
                              });
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
                      children: orders.isEmpty
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
                                        borderRadius:
                                            BorderRadius.circular(8))),
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
                                    onPressed: isUpdateEnabled
                                        ? fetchUpdateOrder
                                        : null,
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
                                        fetchDeleteById(
                                            orders[selected]['_id']);
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              AppColor.primary.color,
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
                                      )),
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
                                                  orders.isNotEmpty
                                                      ? orders[selected]
                                                              ['Name'] ??
                                                          ''
                                                      : '',
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        "Times New Roman",
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
                                                      icon: const Icon(
                                                          Icons.save),
                                                      onPressed: onSaveTitle,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.close),
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
                              ExpansionWidget(
                                title: "Ordered info",
                                trailingIcon: const Icon(Icons.add, size: 14),
                                onTrailingActionStarted: onAddOrder,
                                children: [
                                  ...orders[selected]['DishQty']
                                      .map<Widget>((order) {
                                    return Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(order['Dish']),
                                          Text(order['Qty'].toString()),
                                          TextButton(
                                            onPressed: () => onDeleteOrderInfo(
                                                order['Dish']),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.primary.color,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Icon(Icons.delete,
                                                size: 14),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ],
                    )),
              ),
            ],
          ),
        ),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  void onSearch(String s) {}

  void onEditTitle() {
    setState(() {
      isEditingTitle = !isEditingTitle;
    });
    if (orders.isNotEmpty && selected >= 0 && selected < orders.length) {
      _titleController.value = _titleController.value.copyWith(
        text: orders[selected]['Name'] ?? '',
        selection: TextSelection.collapsed(
            offset: (orders[selected]['Name'] ?? '').length),
      );
    }
  }

  void onSaveTitle() {
    setState(() {
      isEditingTitle = false;
      isUpdateEnabled = true;
      orders[selected]['Name'] = _titleController.text;
    });
  }

  void onCancelTitle() {
    setState(() {
      isEditingTitle = false;
    });
  }

  void onAddOrder() {}

  void onDeleteOrderInfo(String name) {
    setState(() {
      orders[selected]['DishQty'].removeWhere((order) => order['Dish'] == name);
      isUpdateEnabled = true;
    });
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });

    final response = await OrdersService.fetchGetAllOrders();

    if (response != null) {
      setState(() {
        orders = response;
      });
    } else {
      // print('Get Failed');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchUpdateOrder() async {
    final isSuccess = await OrdersService.updateOrder(orders, selected);
    if (isSuccess) {
      setState(() {
        isLoading = true;
        isUpdateEnabled = false;
        fetchOrders();
      });
    } else {}
  }

  Future<void> fetchDeleteById(String id) async {
    final isSuccess = await OrdersService.deleteById(id);
    if (isSuccess) {
      final filtered = orders.where((element) => element['_id'] != id).toList();
      setState(() {
        isLoading = true;
        orders = filtered;
        fetchOrders();
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
