import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_freelance_system_flutter_frontend/models/proposal.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class ProposalDataProvider {
  final http.Client httpClient;

  ProposalDataProvider(this.httpClient);
  Future<Proposal> submitProposal(
      Proposal proposal, String jobTitle, String username) async {
    final url = Uri.parse(apiUrl + '/:$username/job/:$jobTitle');
    print(url);

    final body = json.encode(<String, String>{
      'paymentForJob': proposal.paymentForJob,
      'finishingTime': "One Month",
      'coverLetter': proposal.coverletter
    });

    print(body);
    try {
      final response = await http.post(url, body: body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return Proposal.fromJson(json.decode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
