const { defineConfig } = require('@vue/cli-service');

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    proxy: {
      '/': { 
        target: 'https://localhost:5500',
        changeOrigin: true,
      }, 
    },
  },
})
