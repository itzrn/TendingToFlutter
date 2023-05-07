// ignore_for_file: file_names

import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDBConnection {
  static insert(String pID, String pName, String pPrice) async {
    var db = await Db.create(MONDODB_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    await collection.insertOne(
        {"Product ID": pID, "Product Name": pName, "Product price": pPrice});
  }

  static Future<List<Map<String, Object?>>> getData() async {
    var db = await Db.create(MONDODB_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    final arrData = await collection.find().toList();
    // print(arrData[0]["_id"].runtimeType);
    return arrData;
  }

  static void deleteOne(Object? objectId) async {
    // deleting using object id
    var db = await Db.create(MONDODB_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    await collection.deleteOne({"_id": objectId});
  }

  static void updateOne(Object? objectId,
      {String? pName, String? pPrice, String? pId}) async {
    var db = await Db.create(MONDODB_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    if (pName != null && pPrice != null && pId != null) {
      await collection.update(
          where.eq("_id", objectId), modify.set("Product Name", pName));
      await collection.update(
          where.eq("_id", objectId), modify.set("Product ID", pId));
      await collection.update(
          where.eq("_id", objectId), modify.set("Product price", pPrice));
    }else if(pName!=null && pId!=null){
        await collection.update(
            where.eq("_id", objectId), modify.set("Product Name", pName));
        await collection.update(
            where.eq("_id", objectId), modify.set("Product ID", pId));
    }else if(pName!=null && pPrice!=null){
          await collection.update(
              where.eq("_id", objectId), modify.set("Product Name", pName));
          await collection.update(
            where.eq("_id", objectId), modify.set("Product price", pPrice));
    }else if(pId!=null && pPrice!=null){
          await collection.update(
            where.eq("_id", objectId), modify.set("Product price", pPrice));
          await collection.update(
            where.eq("_id", objectId), modify.set("Product ID", pId));
    }else if(pName!=null){
          await collection.update(
            where.eq("_id", objectId), modify.set("Product Name", pName));
    }else if(pPrice!=null){
          await collection.update(
            where.eq("_id", objectId), modify.set("Product price", pPrice));
    }
    else{
      await collection.update(
          where.eq("_id", objectId), modify.set("Product ID", pId));
    }
  }
}
