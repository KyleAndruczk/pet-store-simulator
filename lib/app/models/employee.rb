# Employee -< Adoption
# Store -< Employee
class Employee < ActiveRecord::Base
    has_many :adoptions
    has_many :pets, through: :adoptions
    belongs_to :store


    def pets_at_my_store
        # Pet.all.select{|pet| pet.id == self.adoptions.pet_id}
        self.pets
        # puts "test"
    end

    def find_dead_pets
        # dead_pets = []
        # self.pets.each do |pet|
        #     if pet.alive == false
        #         dead_pets << pet
        #     end
        #     dead_pets.each do |pet|
        #         Pet.destroy(pet.id)
        #     end
        # end

        self.pets.select { |pet| pet.alive == false }
    end

    def remove_dead_pets
        dead_pets = self.find_dead_pets
        dead_pets.each do |pet|
            Pet.destroy(pet.id)
        end
    end

    def remove_all_pets
        pets_arr = self.pets.ids
        Pet.destroy(pets_arr)
    end
    # to avoid error with Employee.create in CLI
    def self.add_to_db(name, years, full_time, hours, age, salary, store_id)
        self.create(name: name, years_experience: years, full_time: full_time, hours_scheduled: hours, age: age, salary: salary, store_id: store_id)
    end

end