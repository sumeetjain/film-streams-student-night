module ReferralsHelper

  def render_checkboxes_new
    return_string = '<div>'
    alternate = 0 
    Referral.referral_types.each do |referral| 
      if alternate.even? 
        return_string += '<tr><td><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '">&nbsp;' + referral[0].to_s + '</td>'
      else
        return_string += '<td><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"> &nbsp;' + referral[0].to_s + '</td></tr>'
      end 
      alternate += 1 
    end
    return_string += '</div>'
    return return_string.html_safe 
  end

  def render_checkboxes_update(student_id)
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
          return_string += '<tr><td><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '" checked> &nbsp;' + referral[0].to_s + '</td>'
        else
          return_string += '<tr><td><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"> &nbsp;' + referral[0].to_s + '</td>'
        end
      else
        if referrals_to_compare.include?(referral[0])
          return_string += '<td><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '" checked> &nbsp;'  + referral[0].to_s + '</td></tr>'
        else
          return_string += '<td><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"> &nbsp;'  + referral[0].to_s + '</td></tr>'
        end 
      end 
      alternate += 1 
    end
    return_string += '</div>'
    return return_string.html_safe  
  end
end
