const pkg = require('./package.json');
module.exports = {
  // docker 名称
  repository: 'yyt-base',
  // tag
  tag: pkg.version,
  // 推送的
  pushPrefix: 'jackness1208',
  // 自动 更新 history
  rewriteHistory: true,
  // 加速地址
  registryMirror: 'registry.docker-cn.com'
};
