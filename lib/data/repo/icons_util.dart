import 'package:cohoresourceapp_android/data/model/category_model.dart';
import 'package:flutter/material.dart';

class IconsUtil {
    static var _iconmap = {
        'book': Icons.auto_stories,
        'businessperson1': Icons.person,
        'businessperson2': Icons.account_box,
        'businessperson3': Icons.account_circle,
        'businessperson4': Icons.person,
        'car': Icons.commute,
        'disability': Icons.accessible,
        'dollarsign': Icons.attach_money,
        'education': Icons.school,
        'family': Icons.family_restroom,
        'fax': Icons.local_printshop,
        'gears': Icons.settings,
        'handheart': Icons.group,
        'heart': Icons.favorite,
        'house1': Icons.home,
        'location': Icons.location_on,
        'phone': Icons.phone,
        'plug': Icons.power,
        'search': Icons.search,
        'shirt': Icons.dry_cleaning,
        'squares': Icons.category,
        'tornado': Icons.waves,
        'veteran': Icons.perm_identity
    };

    static IconData iconForCat(CategoryModel category) {
        // most categories list their icon name as categories/{icon} so we need to check for that first
        var split = category.icon.split("/");
        String keyValue = "";
        if (split.length == 2) {
            keyValue = split[1];
        } else {
            // if it doesn't contain a /, use the full thing as a key value
            keyValue = category.icon;
        }

        IconData icon = _iconmap[keyValue];

        // provide a default value if it doesn't exist
        if (icon == null) {
            icon = Icons.apps;
        }

        return icon;
    }
}