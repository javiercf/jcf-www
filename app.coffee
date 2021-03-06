axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
ClientTemplates = require 'client-templates'
contentful = require 'roots-contentful'
marked = require 'marked'
slug = require 'slug'

module.exports =
	ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

	locals:
		markdown: marked

	extensions: [
		js_pipeline(files: 'assets/js/*.coffee', out:'/js/main.js'),
		css_pipeline(files: 'assets/css/*.styl', out:'/css/styles.css'),
		ClientTemplates(
			base: "views/templates/", # required
			pattern: "**/*.jade", # defaults to **
			out: "/js/templates.js" # defaults to js/templates.js
		),
		contentful(
			access_token: 'fcecf66c49f21c557e882bddff5b548bd385db19ea1caa2aedb3d4cab3aa68a6',
			space_id: '3wro0m3im9aa',
			content_types:
				projects:
					id:'1HtjYWahv6QGyS4KoWm0S2',
					name:'Project',
					template: 'views/single-project.jade',
					path: (e) -> "work/#{slug(e.title, {lowercase:true})}"
			)

	]

	stylus:
		use: [axis(), rupture(), autoprefixer()]
		sourcemap: true

	'coffee-script':
		sourcemap: true

	jade:
		pretty: true