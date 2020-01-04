module.exports = {
  publicPath:'./',//vue-cli3.3+新版本使用
	//输出文件目录
	outputDir: 'mcdonalds',
    pages: {
      login: {
        // page 的入口
        entry: 'src/login/login.js',
        // 模板来源
        template: 'public/login.html',
        // 在 dist/index.html 的输出
        filename: 'login.html',
        // 当使用 title 选项时，
        // template 中的 title 标签需要是 <title><%= htmlWebpackPlugin.options.title %></title>
        //title: 'Index Page',
        // 在这个页面中包含的块，默认情况下会包含
        // 提取出来的通用 chunk 和 vendor chunk。
        chunks: ['chunk-vendors', 'chunk-common', 'login']
      },
      test: {
        // page 的入口
        entry: 'src/test/do.js',
        // 模板来源
        template: 'public/test.html',
        // 在 dist/index.html 的输出
        filename: 'test.html',
        // 当使用 title 选项时，
        // template 中的 title 标签需要是 <title><%= htmlWebpackPlugin.options.title %></title>
        title: '我裂开了',
        // 在这个页面中包含的块，默认情况下会包含
        // 提取出来的通用 chunk 和 vendor chunk。
        chunks: ['chunk-vendors', 'chunk-common', 'test']
      },
      main: {
        entry: 'src/main/main.js',
        template: 'public/main.html',
        filename: 'main.html',
        chunks: ['chunk-vendors', 'chunk-common', 'main']
      },
      chart: {
        entry: 'src/chart/chart.js',
        template: 'public/chart.html',
        filename: 'chart.html',
        chunks: ['chunk-vendors', 'chunk-common', 'chart']
      },
      setting: {
        entry: 'src/setting/setting.js',
        template: 'public/setting.html',
        filename: 'setting.html',
        chunks: ['chunk-vendors', 'chunk-common', 'setting']
      },
      // 当使用只有入口的字符串格式时，
      // 模板会被推导为 `public/subpage.html`
      // 并且如果找不到的话，就回退到 `public/index.html`。
      // 输出文件名会被推导为 `subpage.html`。
      //subpage: 'src/subpage/main.js'
    }
}