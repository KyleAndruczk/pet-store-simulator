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

    def change_status
        if self.full_time == true
            self.full_time = false
        else self.full_time = true
        end
    end

    def change_hours_scheduled(new_hours)
        self.hours_scheduled = new_hours
    end

    def delete_my_profile
        self.clear
    end

    def change_store(new_store)
        self.store = new_store
    end

    def make_adoption(pet_id)
        Adoption.create(employee_id: self.id, pet_id: pet_id)
    end

    def make_sale(product_id, customer_id)
        Sale.create(employee_id: self.id, product_id: product_id, customer_id: customer_id)
    end

    def make_return(sale_id)
        self.sales.all.each do |sale|
            if sale.id == sale_id
                sale.clear
            end
        end
    end

    def products_sold_at_my_store
        Product.all.select{|product| product.store_id == self.store.id}
    end

    def sort_pets_by_yrs
        self.pets.sort_by{|pet| pet.years_in_captivity}
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

    def self.add_to_db(name, years, full_time, hours, age, salary, store_id)
        self.create(name: name, years_experience: years, full_time: full_time, hours_scheduled: hours, age: age, salary: salary, store_id: store_id)
    end

end