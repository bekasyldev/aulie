import 'package:flutter/material.dart';
import 'package:granth_flutter/models/category_model.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryAppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<CategoryBookResponse>? mSubCatList;
  final int? totalBooks;
  final String? selectedName;
  final Function(String?)? onUpdate;

  /// you can add more fields that meet your needs

  CategoryAppBarComponent({Key? key, this.title, this.mSubCatList, this.totalBooks, this.selectedName, this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isWeb ? context.dividerColor.withOpacity(0.1) : context.scaffoldBackgroundColor,
      iconTheme: context.theme.iconTheme,
      centerTitle: this.mSubCatList!.isEmpty,
      title: this.mSubCatList!.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(this.title.validate(), style: boldTextStyle()).paddingTop(this.totalBooks != 0 ? 12.0 : 0.0),
              ],
            )
          : Theme(
              data: ThemeData(canvasColor: Theme.of(context).cardTheme.color),
              child: DropdownButton<String>(
                value: this.selectedName,
                dropdownColor: context.cardColor,
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  this.onUpdate?.call(newValue);
                },
                items: this.mSubCatList!.map(
                  (category) {
                    return DropdownMenuItem(
                      child: Text(category.categoryName.validate(value: ""), style: boldTextStyle()),
                      value: category.categoryName,
                    );
                  },
                ).toList(),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(60);
}
