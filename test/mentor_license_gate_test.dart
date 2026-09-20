import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_model_spec.dart';

void main() {
  test('license gates only on Research and Llama', () {
    expect(MentorModelCatalog.qwen15.requiresLicenseAcceptance, isFalse);
    expect(MentorModelCatalog.qwen15.licenseId, 'apache-2.0');

    expect(MentorModelCatalog.qwen3.requiresLicenseAcceptance, isTrue);
    expect(MentorModelCatalog.qwen3.licenseId, 'qwen-research');

    expect(MentorModelCatalog.llama32.requiresLicenseAcceptance, isTrue);
    expect(MentorModelCatalog.llama32.licenseId, 'llama-3.2-community');
  });
}
