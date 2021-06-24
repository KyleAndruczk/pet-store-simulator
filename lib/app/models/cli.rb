require "tty-prompt"
require "tty-font"
require "tty-table"

class CLI
    @@prompt = TTY::Prompt.new
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)
    @@chosen_store = nil
    @@resume = nil
    @@user = nil
    @@boss_name


    def self.print_title_art
        art = <<-'HRD'
                      /^--^\     /^--^\     /^--^\
                      \____/     \____/     \____/
                     /      \   /      \   /      \
                    |        | |        | |        |
                     \__  __/   \__  __/   \__  __/
|^|^|^|^|^|^|^|^|^|^|^|^\ \^|^|^|^/ /^|^|^|^|^\ \^|^|^|^|^|^|^|^|^|^|^|^|
| | | | | | | | | | | | |\ \| | |/ /| | | | | | \ \ | | | | | | | | | | |
########################/ /######\ \###########/ /#######################
| | | | | | | | | | | | \/| | | | \/| | | | | |\/ | | | | | | | | | | | |
|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|
    HRD
    puts art
    end

    def self.print_resume_art

        art = <<-'HRD'
                          _______
                         | ___  o|
                         |[_-_]_ |
      ______________     |[_____]|
     |.------------.|    |[_____]|
     ||            ||    |[====o]|
     ||    Job     ||    |[_.--_]|
     ||Application ||    |[_____]|
     ||            ||    |      :|
     ||____________||    |      :|
 .==.|""  ......    |.==.|      :|
 |::| '-.________.-' |::||      :|
 |''|  (__________)-.|''||______:|
 `""`_.............._\""`______
    /:::::::::::'':::\`;'-.-.  `\
   /::=========.:.-::"\ \ \--\   \
   \`""""""""""""""""`/  \ \__)   \
    `""""""""""""""""`    '========'
    HRD
    puts art
    end

    def self.print_boss_art
        art = <<-'HRD'
                                
                   ;;;;;;;;;;;;;;;;;
                ;;;;;;;;;;;;     ;;;;;
               ;;;;;    ;;;         \;;
              ;;;;;      ;;          |;
             ;;;;         ;          |
             ;;;                     |
              ;;                     )
               \    ~~~~ ~~~~~~~    /
                \    ~~~~~~~  ~~   /
              |\ \                / /|
               \\| %%%%%    %%%%% |//
              [[====================]]
               | |  ^          ^  |
               | | :@: |/  \| :@: | |
                \______/\  /\______/
                 |     (@\/@)     |
                /                  \
               /  ;-----\  ______;  \
               \         \/         /
                )                  (
               /                    \
               \__                  /
                \_                _/
                 \______/\/\______/
                  _|    /--\    |_
                 /%%\  /"'"'\  /%%\
  ______________/%%%%\/\'"'"/\/%%%%\______________
 / :  :  :  /  .\%%%%%%%\"'/%%%%%%%/.  \  :  :  : \
)  :  :  :  \.  .\%%%%%%/'"\%%%%%%/.  ./  :  :  :  (

        HRD
        puts art
    end

    def self.print_dog
        art = <<-'HRD'
            |\_/|        D\___/\
            (0_0)         (0_o)
           ==(Y)==         (V)
----------(u)---(u)----oOo--U--oOo---
__|_______|_______|_______|_______|___

        HRD
        puts art
    end

    def self.print_office
        art = <<-'HRD'
::::==========:::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::=========::::::.---------------.:::::::::::::::::::::::::::::::
:::=============::::::| .-----------. |:::::::::::::::::::::::::::::
::::==========::::::::| | === == == | |:::::::::::::::::::::::::::::::::
::::==========::::::::| | PETS R US | |:::::::::::::::::::::::::::::::
:::::::=========='::::| |   SELL!!  | |:::::::::::::::::::::::::::::
:::===========::::::::| |___________| |::::::((;):::::::::::::::::::::
""""============""""""|___________oo__|"")"""";(""""""""""""""""""""""
  ==========='           ___)___(___,o  (   .---._
     ===========        |___________| 8  \  |   |_)    .+-------+.
  ===========                     o8o8    ) |___|    .' |_______| `.
    =============      __________8___    (          /  /         \  \
 |\`==========='/|   .'= --------- --`.   `.       |\ /           \ /|
 | "-----------" |  / ooooooooooooo  oo\   _\_     | "-------------" |
 |______I_N______| /  oooooooooooo[] ooo\  |=|     |_______OUT_______|
                  / O O =========  O OO  \ "-"   .-------,
                  `""""""""""""""""""""""'      /~~~~~~~/
_______________________________________________/_   ~~~/_______________
hjw.......................................... \/_____/.................


        HRD
        puts art
    end 

    def self.print_tomb
        art = <<-'HRD'
      ,-=-.       ______     
     /  +  \     />----->  
     | ~~~ |    //     /  
     |R.I.P|   //     /     
\vV,,|_____|V,//_____/VvV,v,

        HRD
        puts art
    end


    def self.title_screen
        system('clear')
        self.title
        self.print_title_art
        self.start_menu
    end

    def self.title
        puts @@pastel.blue(@@font.write("Pet Store Simulator", letter_spacing: 2))
    end

    def self.start_menu
        new_prompt = TTY::Prompt.new

        selection = new_prompt.select("\n\nWelcome to your new Job!") do |option|
            option.choice "Start Game"
            option.choice "Quit Game"
        end 

        if selection == "Start Game"
            self.build_resume
            self.choose_store
            self.get_hired
            self.start_work
        else
            exit
        end
    end

    def self.build_resume
        system('clear')
        self.title
        self.print_resume_art
        prompt = TTY::Prompt.new
        puts "Let's make a Job Application!\n\n"
        @@resume = prompt.collect do 
            key(:name).ask("What is your name?")

            key(:age).ask("How old are you? (shhhhhh OSHA doesn't exist)", convert: :int)
            
            key(:hours).ask("How many hours do you want to work a week?", convert: :int)

            key(:exp).ask("How many years experience do you have?", convert: :int)
        end 

    end

    def self.choose_store
        system('clear')
        self.title
        prompt = TTY::Prompt.new
        @@chosen_store = prompt.select("What store do you want to apply to?\n") do |menu|
            Store.all.map do |store|
                menu.choice "#{store.name.rjust(20)}" + "\n\tAverage Wage: $#{store.avg_wage}" + "\t |   Number of Employees: #{store.num_emps_at_store}\n"
            end
        end

    end

    def self.get_hired
        system('clear')
        self.title
        self.print_boss_art

        chosen_store_arr = @@chosen_store.split

        choosen_store_name_str = "#{chosen_store_arr[0]}" + " #{chosen_store_arr[1]}" + " #{chosen_store_arr[2]}" 
        # get the store owner's name
        boss_name = "#{chosen_store_arr[0]}"
        @@boss_name = boss_name[0..((boss_name.length) - 3)]
        

        store_obj = Store.all.find { |store| store.name == choosen_store_name_str }

        avg_wage = store_obj.avg_wage

        if @@resume[:hours] < 38 
            full_time = 0
        else 
            full_time = 1
        end

        puts "#{@@boss_name}:  Congratulations, #{@@resume[:name]}, you're hired! #{@@resume[:hours]} hours sounds great! Since you only have #{@@resume[:exp]} years of experience, you'll be payed half of our average salary\n\t because, ya know, capitalism"
        puts "\nStarting Salary: $#{(avg_wage/2.0).to_i}\tHours Scheduled: #{(@@resume[:hours])}"
        # salary 
        
        @@user = Employee.add_to_db(@@resume[:name], @@resume[:exp], full_time, (@@resume[:hours]), @@resume[:age], (avg_wage/2.0).to_i, store_obj.id)
        # for some reason using @@user.pets later was causing bugs
        user_obj = Employee.all.find {|emp| emp.id == @@user.id}

        5.times do
            species = ["Cat", "Dog", "Bird", "Lizard", "Frog"]
            new_pet = Pet.create(nickname: Faker::FunnyName.name, species: species.sample, weight: rand(1.0..20.0).round(2), age: rand(1..20), alive: rand(0..1), years_in_captivity: rand(0..10), price: rand(1.5...100.0).round(2))
            Adoption.create(employee_id: user_obj.id, pet_id: new_pet.id)
        end
        self.return_to_work
    end

    def self.start_work
        system('clear')
        self.title
        self.print_office
        # for some reason using @@user.pets later was causing bugs
        user_obj = Employee.all.find {|emp| emp.id == @@user.id}
        

        new_prompt = TTY::Prompt.new

        selection = new_prompt.select("\n\n You're at work now, what do you want to do?\n\n") do |option|
            option.choice "View the all of the pets that I have" # kyle
            option.choice "Adopt a new pet" # new adoption instance # kyle
            option.choice "Change my schedule" # change hours #kyle 
            option.choice "EWWWW! What's that smell?" #remove the dead pets Lindsay 
            option.choice "Change what store I work at" #change store Lindsay 
            option.choice "Quit my job!" # delete employee instance (the @@user/user_obj) Lindsay 
            # for quitting, Delete the obj from the db (.delete), then call self.start_menu
        end 

        if selection == "View the all of the pets that I have"



            all_pets = user_obj.pets.each_with_object([]) do |pet, fin_arr|

                vals = pet.attributes.values

                vals_as_strs = vals.map do |val|
                    val.to_s
                end 

                fin_arr << vals_as_strs[1..-1]
            end 


            table = TTY::Table.new(["Nickname","Species", "Weight (lbs)", "Age", "Alive", "Years in Captivity", "Price ($)"], all_pets.uniq)
            puts table.render(:ascii)

            self.return_to_work
        end
        if selection == "Adopt a new pet"
            system('clear')
            self.title
            new_prompt = TTY::Prompt.new
    
            puts "\n\nTime to get a new pet!\n\n"
    
            selection_hash = new_prompt.collect do 
                key(:species).ask("What species is the pet?")
    
                key(:nickname).ask("What is the pet's nickname?")
            end 
    
            system('clear')
            self.title
            
            new_pet = Pet.create(nickname: selection_hash[:nickname], species: selection_hash[:species], weight: rand(1.0..20.0).round(2), age: rand(1..20), alive: 1, years_in_captivity: 0, price: rand(1.5...100.0).round(2))
            Adoption.create(employee_id: user_obj.id, pet_id: new_pet.id)
    
            self.print_boss_art
            puts "#{@@boss_name}:  Alright, #{@@resume[:name]}, fine--I got that new pet you wanted. Its name is #{new_pet.nickname},\n\t and it's an #{new_pet.weight} lbs #{new_pet.age}-year-old #{new_pet.species}. \n\t And the $#{new_pet.price} it costed is coming out of YOUR paycheck!"
            self.return_to_work
        end
        if selection == "Change my schedule"
            system('clear')
            self.title
            new_prompt = TTY::Prompt.new
    
            if user_obj.full_time 
                work_status = "Full Time"
            else
                work_status = "Part Time"
            end 
    
            puts "\n\nHOURS SCHEDULED FORM\n\nEmployee: #{@@resume[:name]}\n Hours this Week: #{user_obj.hours_scheduled}\n Status: #{work_status}\n"
        
            selection_hash = new_prompt.collect do 
                key(:hrs).ask("How many hours do you want to work", convert: :int)
    
                key(:full_time).ask("Do you want to have full-time benefits?")
            end 
    
            self.print_boss_art
    
            if selection_hash[:hrs] >= 80
                full_time = rand(0.0..1.0).round
            end

            if full_time
                puts "#{@@boss_name}: Hmmm . . . #{selection_hash[:hrs]} is a lot. You can be full-time."
                user_obj.full_time = true
                work_status = "Full Time"
            else
                puts "#{@@boss_name}: No way you can have full-time benefits--way too expensive! Maybe I'll consider you for full time benefits if you do at least 80 hours a week."
                user_obj.full_time = false
                work_status = "Part Time"
            end 

            user_obj.hours_scheduled = selection_hash[:hrs]

            puts "\nYou are now scheduled for #{selection_hash[:hrs]} hours and have #{work_status} benefits"

            self.return_to_work
        end 

        if selection == "EWWWW! What's that smell?"
            dead_pets = user_obj.find_dead_pets
            
            if dead_pets != []
                first_half =  "\n\nOH NO!! someone forgot to feed these pets: "
                dead_pets_names = dead_pets.map {|pet| pet.nickname}
                other_half = dead_pets_names.join(", ")

                puts first_half + other_half

                self.print_tomb

                puts "\nYou're going to have to bury them :("
            else
                puts "\n\nHuh, all of the pets are ok--must've been a gas leak"
            end

            user_obj.remove_dead_pets

            self.return_to_work
        end
    
        if selection == "Change what store I work at"

            system('clear')
            self.print_boss_art
            puts "#{@@boss_name}: FINE! You can leave, but the pets you somehow kept alive (or didn't!) stay with me at my store!"
            sleep(5)


            user_obj.remove_all_pets

         

            Employee.destroy(user_obj.id)
            self.choose_store
            self.get_hired
            self.return_to_work
            
        end
    
        if selection == "Quit my job!"
            user_obj.remove_all_pets
            Employee.destroy(user_obj.id)
            puts "\nCongratulations, you have quit your job!\n\nYou set all of your pets at the store free on your way out!"
            self.print_dog
            sleep(6)
            CLI.title_screen
        end

    end


    def self.return_to_work
        new_prompt = TTY::Prompt.new
        selection = new_prompt.select("\n\nReturn when you're ready") do |option|
            option.choice "Return to Work!" 
        end 
        
        if selection == "Return to Work!"
            self.start_work
        end
    end

end