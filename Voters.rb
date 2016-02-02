@list = {}

def names_list
  puts @list.keys
end

def done_message
  system "clear"
  puts "Done!\n"
end

def delete
  system "clear"
  if @list == {} 
    puts """No one to delete!
Type any key to return to the main menu"""
    gets
    system "clear"
    main_menu 
  else
    system "clear"
    names_list 
    puts
    puts "Which of these people would you like to delete?"
    @name = gets.chomp.downcase.strip.capitalize
    if @list.keys.include? @name
      system "clear"
      puts "#{@name} will be deleted. Are you sure? (Y/N)"
      delete_confirmation = gets.chomp.downcase.strip
      if delete_confirmation == "y"
        @list.delete(@name)
        done_message
        main_menu
      else  
        system "clear"
        puts "Deletion aborted. Returning to main menu."
        main_menu
      end
    else 
    puts """
    That person does not exist. Check for case sensitivity and spelling.
    Returning to main menu"""
    main_menu
    end
  end
end

def create_politician
  puts "Is this politician a (D)emocrat or a (R)epublican?"
  @party = gets.chomp.strip
  if @party.downcase == "d"
    @party = "Democrat"
  elsif @party.downcase == "r"
    @party = "Republican"
  else
    puts "Invalid response. Try again."
    create_politician
  end
  @list[@name] = [@poli_or_voter, @party]
  done_message
  main_menu
end

def create_voter
  puts """Would you like this voter to be (L)iberal, (C)onservative,
(T)ea Party, (S)ocialist, or (N)eutral"""
  voter_politics = gets.chomp.downcase.strip
  case voter_politics
  when "l"
    @list[@name] = [@poli_or_voter, "Liberal"]
  when "c"
    @list[@name] = [@poli_or_voter, "Conservative"]
  when "t"
    @list[@name] = [@poli_or_voter, "Tea Party"]
  when "s"
    @list[@name] = [@poli_or_voter, "Socialist"]
  when "n"
    @list[@name] = [@poli_or_voter, "Neutral"]
  else
    puts
    puts "Invalid response, try again"
    create_voter
  end
  done_message
  main_menu
end

def create_method_part2
  puts "Would you like to create a (P)olitician or a (V)oter"
  @poli_or_voter = gets.chomp.downcase.strip
  if @poli_or_voter == "p"
    @poli_or_voter = "Politician"
    create_politician
  elsif @poli_or_voter == "v"
    @poli_or_voter = "Voter"
    create_voter
  else
    puts "Invalid response, try again"
    create_method_part2
  end
end

def create_method_part1
  puts "What will this person's name be?"
  @name = gets.chomp.downcase.strip.capitalize
    if @list.include? @name
      system "clear"
      puts "Sorry this person already exists, returning to main menu"
      main_menu
    else
      create_method_part2
    end
end

def show_list
  system "clear"
  puts "Nothing here!\n" if @list == {}
  @list.each {|name, array|
    puts name + " " + array[0] + " " + array[1]
  }
  puts "\nWhen finished, press any key to return to the main menu"
  gets
  system "clear"
  main_menu
end

def update_name
  puts "Ok what will #{@person}'s new name be?"
  new_name = gets.chomp.downcase.strip.capitalize
  @list[new_name] = @list.delete(@person)
  done_message
  main_menu
end

def update_voter
  puts "(P)olitics"
  update_v_reply = gets.chomp.downcase.strip
  if update_v_reply == "p"
    puts """Would you like this voter to be (L)iberal, (C)onservative,
(T)ea Party, (S)ocialist, or (N)eutral"""
    change_voter_politics = gets.chomp.downcase.strip
    case change_voter_politics
    when "l"
      @list[@person][1] = "Liberal"
    when "c"
      @list[@person][1] = "Conservative"
    when "t"
      @list[@person][1] = "Tea Party"
    when "s"
      @list[@person][1] = "Socialist"
    when "n"
      @list[@person][1] = "Neutral"
    else
      puts "Invalid response, try again"
      update
    end
    done_message
    main_menu
  elsif update_v_reply == "n"
    update_name
    puts "Invalid response, try again"
    update
  end
end

def update_politician
  puts "(P)arty"
  update_p_reply = gets.chomp.downcase.strip
  if update_p_reply == "p"
    system "clear"
    puts "Ok. Would you like this politician to be a (D)emocrat or a (R)epublican?"
    change_party_reply = gets.chomp.downcase.strip
    if change_party_reply == "d"
      @list[@person][1] = "Democrat"
      done_message
      main_menu
    elsif change_party_reply == "r"
      @list[@person][1] = "Republican"
      done_message
      main_menu
    else
      puts "Invalid response, try again"
      update
    end
  elsif update_p_reply == "n"
    update_name
  else
    puts "Invalid response, try again"
    update
  end
end

def update
  if @list != {}
    puts
    names_list
    puts
    puts "Which of these people would you like to update?"
    @person = gets.chomp.downcase.strip.capitalize
    if @list.include? @person
      puts
      puts "What would you like to update about #{@person}?"
      print "(N)ame or "
      update_politician if @list[@person][0] == "Politician"
      update_voter if @list[@person][0] == "Voter"
    else
      puts
      puts "That person does not exist. Check for spelling and case sensitivity."
      puts "Returning to main menu"
      main_menu
    end
  else
    system "clear"
    puts "No one to update!"
    puts "\nPress any key to return to the main menu."
    gets
    system "clear"
    main_menu
  end
end

def main_menu
  p @list  
  main_menu_string = "MAIN MENU"
  puts main_menu_string.center(68, "-")
  puts
  puts """What would you like to do?
  (C)reate, (L)ist, (U)pdate, or (D)elete"""
  main_menu_reply = gets.chomp.downcase.strip
  if main_menu_reply == "c"
    create_method_part1
  elsif main_menu_reply =="l"
    show_list
  elsif main_menu_reply == "u"
    update
  elsif main_menu_reply == "d"
    delete
  else
    puts
    puts "Invalid response, please select a valid option"
    main_menu
  end
end
main_menu