#Associations I: belongs_to and has_many#

#When you create your migrations, you'll set up foreign key references between entities.
class CreateCoursesAndProfessorsTables < ActiveRecord::Migration[5.1]
  def change
    create_table :professors do |t|
      t.string :name
      t.string :thesis_title

      t.timestamps
    end

    create_table :courses do |t|
      t.string :course_name
      t.integer :professor_id
    end
  end
end
#Given a Course, how shall we find the professor? One way is this:
Professor.find(course.professor_id)
#to find the courses a professor is teaching:
Course.where('professor_id = ?', prof.id)

#This is tedious and low-level; we need to pull out the foreign key, then explicitly look it up in the professors table. 
#Associations tell ActiveRecord (through ApplicationRecord)
class Course < ApplicationRecord
  belongs_to(
    :professor,
    class_name: 'Professor',
    foreign_key: :professor_id,
    primary_key: :id
    optional: true #Rails5 allow the association to be null
  )
end

class Professor < ApplicationRecord
  has_many(
    :courses, #name of a has_many association is pluralized
    class_name: 'Course',
    foreign_key: :professor_id
    primary_key: :id
  )
end

# belongs_to and has_many methods exist in a module named ActiveRecord::Associations::ClassMethods.
course.professor # the professor for a course
# => SELECT
#      professors.*
#    FROM
#      professors
#    WHERE
#      professors.id = ?
#    LIMIT
#      1
professor.courses # an array of the courses a professor teaches
# => SELECT
#      courses.*
#    FROM
#      courses
#    WHERE
#      courses.professor_id = ?
#
# The `?` is filled with `professor.id`.

