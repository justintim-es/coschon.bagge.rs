import 'package:conduit/conduit.dart';

class PassengerController extends PassengerController {
  @Operation.post('adId', 'bagger')
  Future<Response> register() async {
    Future<Response> register(@Bind.path('bagger') String bagger, @Bind.body() Advertiser advertiser) async { 
      if (advertiser.username == null || advertiser.password == null || advertiser.username == null) {
        return Response.badRequest(
          body: "email, username and password are required"
        );
      }
      final rationem = await d.Dio().get('${config.gladiatorsurl}/rationem');

      final salt = AuthUtility.generateRandomSalt();
      final confirm = randomAlphaNumeric(256);
      final insertQuery = Query<User>(context)
        ..values.uschus = bagger == 'true' ? Uschus.bagger : Uschus.advertiser
        ..values.email = advertiser.email
        ..values.username = advertiser.username
        ..values.confirmEmail = confirm
        ..values.isConfirmedEmail = false
        ..values.salt = salt
        ..values.private = rationem.data['privatusClavis'].toString()
        ..values.public = rationem.data['publicaClavis'].toString()
        ..values.hashedPassword = authServer.hashPassword(advertiser.password!, salt);
      final msg = Message()
        ..from = Address(config.smtp!.username!, 'Bagge.rs')
        ..recipients.add(advertiser.email)
        ..subject = 'Please confirm your e-mail'    
        ..text = 'Please confirm your e-mail by pressing on the following link\n${config.frontend}/confirm-fetch/true/$confirm';
      await send(msg, smtp);
      await insertQuery.insert();
      return Response.ok("");
  }
}