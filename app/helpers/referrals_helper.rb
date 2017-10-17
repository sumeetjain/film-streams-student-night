module ReferralsHelper


  # Returns an HTML formatted string to display a table of checkboxes representing the available referral types
  def render_checkboxes_new
    return_string = ''
    alternate = 0 
    Referral.referral_types.each do |referral| 
      if alternate.even? 
        return_string += '<tr><td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '">&nbsp;' + referral[0].to_s + '</td>'
      else
        return_string += '<td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"> &nbsp;' + referral[0].to_s + '</td></tr>'
      end 
      alternate += 1 
    end
    return return_string.html_safe 
  end

  # Takes in a students ID and gathers previous referrals for the student and adds their string representations to an array
  def get_past_referrals(student_id)
    referrals_to_compare = [] 
    current_referrals = Referral.where(student_id: student_id) 
   
    current_referrals.each do |referral|
      referrals_to_compare.push(referral.referral_type) 
    end
    return referrals_to_compare
  end

  # Takes in a students id, and gathers all the referral sources they have already selected in the past by calling a function.
  # Returns an HTML formatted string to display a table of checkboxes representing the available referral types, with the students previously selected referrals already checked
  def render_checkboxes_update(student_id)
    referrals_to_compare = get_past_referrals(student_id)
    return_string = ''

    Referral.referral_types.each_with_index do |referral, index| 
      if index.even? 
        if referrals_to_compare.include?(referral[0])
          return_string += '<tr><td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '" checked> &nbsp;' + referral[0].to_s + '</td>'
        else
          return_string += '<tr><td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"> &nbsp;' + referral[0].to_s + '</td>'
        end
      else
        if referrals_to_compare.include?(referral[0])
          return_string += '<td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '" checked> &nbsp;'  + referral[0].to_s + '</td></tr>'
        else
          return_string += '<td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"> &nbsp;'  + referral[0].to_s + '</td></tr>'
        end 
      end 
    end
    return return_string.html_safe  
  end
end
