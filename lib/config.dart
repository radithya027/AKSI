class ConfigEnvironments {
  static Map<String, String> getEnvironments() {
    return {
      'env': Environments.DEVELOPMENT,
    };
  }
}

class Environments {
  static const PRODUCTION = 'Production';
  static const QAS = 'Quality Assurance';
  static const DEVELOPMENT = 'Development';
}
