module ReferralsHelper

  def render_checkboxes_new
    return_string = '<div class="clearfix" style="font-size: .85em;">'
    alternate = 0 
    Referral.referral_types.each do |referral| 
      if alternate.even? 
        return_string += '<div style="float:left"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '">' + referral[0].to_s + '</div>'
      else
        return_string += '<div style="float:right">' + referral[0].to_s + '<input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"></div><br>'
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

    return_string = '<div class="clearfix" style="font-size: .85em;">'
    alternate = 0
    Referral.referral_types.each do |referral| 
      if alternate.even? 
        if referrals_to_compare.include?(referral[0])
          return_string += '<div style="float:left"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '" checked>' + referral[0].to_s + '</div>'
        else
          return_string += '<div style="float:left"><input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '">' + referral[0].to_s + '</div>'
        end
      else
        if referrals_to_compare.include?(referral[0])
          return_string += '<div style="float:right">' + referral[0].to_s + '<input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '" checked></div><br>'
        else
          return_string += '<div style="float:right">' + referral[0].to_s + '<input type="checkbox" name="referrals[]" value="' + referral[1].to_s + '"></div><br>'
        end 
      end 
      alternate += 1 
    end
    return_string += '</div>'
    return return_string.html_safe  
  end
end
