class AlgoliaConfig {
  const AlgoliaConfig(this.id, this.apiKey);
  final String id;
  final String apiKey;
}

const prodConfig = AlgoliaConfig('ALGOLIA_PROD_ID', 'ALGOLIA_DEV_API_KEY');
const devConfig = AlgoliaConfig('ALGOLIA_DEV_ID', 'ALGOLIA_PROD_API_KEY');
