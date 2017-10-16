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

  def render_checkboxes_update

  end
  
end
