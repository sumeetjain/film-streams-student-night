module ReferralsHelper


  # Returns an HTML formatted string to display a table of checkboxes representing the available referral types
  def render_checkboxes_new
    return_string = '<div>'
    alternate = 0 
    Referral.referral_types.each do |referral| 
      if alternate.even? 
        return_string += '<tr><td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '">&nbsp;' + referral[0].to_s + '</td>'
      else
        return_string += '<td style="font-size: .95em"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"> &nbsp;' + referral[0].to_s + '</td></tr>'
      end 
      alternate += 1 
    end
    return_string += '</div>'
    return return_string.html_safe 
  end

  # Takes in a students id, and gathers all the referral sources they have already selected in the past.
  # Returns an HTML formatted string to display a table of checkboxes representing the available referral types, with the students previously selected referrals already checked
  def render_checkboxes_update(student_id)
    # Gathers previous referrals for a student and adds their string representations to an array
    referrals_to_compare = [] 
    current_referrals = Referral.where(student_id: student_id) 
   
    current_referrals.each do |referral|
      referrals_to_compare.push(referral.referral_type) 
    end

    return_string = '<div>'
    alternate = 0
    Referral.referral_types.each do |referral| 
      if alternate.even? 
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
      alternate += 1 
    end
    return_string += '</div>'
    return return_string.html_safe  
  end
end
