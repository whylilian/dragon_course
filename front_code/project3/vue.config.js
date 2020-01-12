module.exports = {
  publicPath:'./',//vue-cli3.3+新版本使用
	//输出文件目录
	outputDir: 'mcdonalds',
    pages: {
      login: {
        entry: 'src/login/login.js',
        template: 'public/login.html',
        filename: 'login.html',
        chunks: ['chunk-vendors', 'chunk-common', 'login']
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
      study: {
        entry: 'src/study/study.js',
        template: 'public/study.html',
        filename: 'study.html',
        chunks: ['chunk-vendors', 'chunk-common', 'study']
      },
      match: {
        entry: 'src/match/match.js',
        template: 'public/match.html',
        filename: 'match.html',
        chunks: ['chunk-vendors', 'chunk-common', 'match']
      },
      teacher: {
        entry: 'src/teacher/teacher.js',
        template: 'public/teacher.html',
        filename: 'teacher.html',
        chunks: ['chunk-vendors', 'chunk-common', 'teacher']
      },
    }
}