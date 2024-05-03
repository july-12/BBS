module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  darkMode: 'false',
  plugins: [require('daisyui')],
  daisyui: {
    // themes: ["cupcake"]
    darkTheme: false,

  }
}
