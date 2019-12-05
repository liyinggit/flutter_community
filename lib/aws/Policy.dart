import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:amazon_cognito_identity_dart/sig_v4.dart';

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  String sessionToken;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize, this.sessionToken,
      {this.region = 'us-east-1'});

  factory Policy.fromS3PresignedPost(
      String key,
      String bucket,
      int expiryMinutes,
      String accessKeyId,
      int maxFileSize,
      String sessionToken, {
        String region,
      }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = Policy(
        key, bucket, datetime, expiration, cred, maxFileSize, sessionToken,
        region: region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
{ "expiration": "${this.expiration}",
  "conditions": [
    {"bucket": "${this.bucket}"},
    ["starts-with", "\$key", "${this.key}"],
    {"acl": "public-read"},
    ["content-length-range", 1, ${this.maxFileSize}],
    {"x-amz-credential": "${this.credential}"},
    {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
    {"x-amz-date": "${this.datetime}" },
    {"x-amz-security-token": "${this.sessionToken}" }
  ]
}
''';
  }
}

void main() async {
  const _awsUserPoolId = 'ap-southeast-xxxxxxxxxxx';
  const _awsClientId = 'xxxxxxxxxxxxxxxxxxxxxxxxxx';

  const _identityPoolId =
      'ap-southeast-1:xxxxxxxxx-xxxx-xxxx-xxxxxxxxxxx';
  final _userPool = CognitoUserPool(_awsUserPoolId, _awsClientId);

  final _cognitoUser = CognitoUser('+60100000000', _userPool);
  final authDetails =
  AuthenticationDetails(username: '+60100000000', password: 'p&ssW0RD');

  CognitoUserSession _session;
  try {
    _session = await _cognitoUser.authenticateUser(authDetails);
  } catch (e) {
    print(e);
  }

  final _credentials = CognitoCredentials(_identityPoolId, _userPool);
  await _credentials.getAwsCredentials(_session.getIdToken().getJwtToken());

  const _region = 'ap-northeast-1';
  const _s3Endpoint =
      'https://community2.s3-ap-northeast-1.amazonaws.com/';

  final file = File(path.join('/path/to/my/folder', 'square-cinnamon.jpg'));

  final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
  final length = await file.length();

  final uri = Uri.parse(_s3Endpoint);
  final req = http.MultipartRequest("POST", uri);
  final multipartFile = http.MultipartFile('file', stream, length,
      filename: path.basename(file.path));

  final policy = Policy.fromS3PresignedPost(
      '2.jpg',
      'community2',
      15,
      _credentials.accessKeyId,
      length,
      _credentials.sessionToken,
      region: _region);
  final key = SigV4.calculateSigningKey(
      _credentials.secretAccessKey, policy.datetime, _region, 's3');
  final signature = SigV4.calculateSignature(key, policy.encode());

  req.files.add(multipartFile);
  req.fields['key'] = policy.key;
  req.fields['acl'] = 'public-read';
  req.fields['X-Amz-Credential'] = policy.credential;
  req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
  req.fields['X-Amz-Date'] = policy.datetime;
  req.fields['Policy'] = policy.encode();
  req.fields['X-Amz-Signature'] = signature;
  req.fields['x-amz-security-token'] = _credentials.sessionToken;

  try {
    final res = await req.send();
    await for (var value in res.stream.transform(utf8.decoder)) {
      print(value);
    }
  } catch (e) {
    print(e.toString());
  }
}