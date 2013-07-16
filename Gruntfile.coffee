module.exports = (grunt) ->
  
  grunt.task.loadTasks 'gruntcomponents/tasks'
  grunt.task.loadNpmTasks 'grunt-contrib-coffee'
  grunt.task.loadNpmTasks 'grunt-contrib-watch'
  grunt.task.loadNpmTasks 'grunt-contrib-concat'
  grunt.task.loadNpmTasks 'grunt-contrib-uglify'

  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')
    banner: """
/*! <%= pkg.name %> (<%= pkg.repository.url %>)
 * lastupdate: <%= grunt.template.today("yyyy-mm-dd") %>
 * version: <%= pkg.version %>
 * author: <%= pkg.author %>
 * License: MIT */

"""

    growl:

      ok:
        title: 'COMPLETE!!'
        msg: '＼(^o^)／'

    coffee:

      allchecker:
        src: [ 'jquery.allchecker.coffee' ]
        dest: 'jquery.allchecker.js'

    concat:

      banner:
        options:
          banner: '<%= banner %>'
        src: [ '<%= coffee.allchecker.dest %>' ]
        dest: '<%= coffee.allchecker.dest %>'
        
    uglify:

      options:
        banner: '<%= banner %>'
      allchecker:
        src: '<%= concat.banner.dest %>'
        dest: 'jquery.allchecker.min.js'

    watch:

      allchecker:
        files: '<%= coffee.allchecker.src %>'
        tasks: [
          'default'
        ]

  grunt.registerTask 'default', [
    'coffee'
    'concat'
    'uglify'
    'growl:ok'
  ]

