import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/model/talk.dart';

class FirestoreService {
  //instanciar a coleção
  CollectionReference talk = FirebaseFirestore.instance.collection('talks');

  Future<String> addTalk(Talk talkData) {
    //adicionar o objecto em forma de json para a coleção de minions
    return talk
        .add(talkData.toJson())
        .then((value) => "save talk data")
        .catchError((error) =>
            "someting wrong on:\n $error");
  }

  // Future<MinionQuerySnapshot> queryCollection(queryString) async {
  //   //retorna o snapshot equivalente aos objectos json onde
  //   // o nome é igual ao passado como argumento
  //   return await minionsRef.whereName(isEqualTo: queryString).get();
  // }

  // Future updateAgenda(id, novoNome) {
  //   //com base na coleção pegamos todos os dados que nela existem, que retorna
  //   //QuerySnapshot e usando o mesmo para iterar pelos documentos dentro dele
  //   return talk.get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       //verificar se o dcumento tem como atributo nome igual ao pretendido alterar
  //       if (doc.id == id) {
  //         agendas
  //             .doc(doc.id) //pegar o id do documento que se pretende actualizar
  //             .update({'day_one': FieldValue.arrayUnion()})
  //             .then((value) => "save agenda")
  //             .catchError((error) => "Oops, something wrong:\n $error");
  //       }
  //     });
  //   });
  // }
}
