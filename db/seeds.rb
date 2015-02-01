# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


genesis_author = Author.create([{id: 0,
                                 name: 'genesis author',
                                 department: 0,
                                 active: false}])

genesis_section = Section.create([{id: 0,
                                   active: false,
                                   module: 'genesis section',
                                   category: 0}])

genesis_publisher = Publisher.create([{id: 0,
                                       active: true,
                                       name: 'Individual contributor'}])

genesis_content = Content.create([{id: 0,
                                   title: 'genesis content',
                                   description: 'do NOT remove',
                                   status: :draft,
                                   content_type: :article,
                                   delete_flag: true,
                                   publisher_id: 0,
                                   section_id: 0,
                                   author_id: 0,
                                   display_on_timeline: false
                                  }])


