module UsersHelper
  def formatted_activation_status_for(user)
    if user.active? 
      raw "<span class=\"label label-success\">#{t('users.index.active')}</span>"
    else
      raw "<span class=\"label label-warning\">#{t('users.index.unactive')}</span>"
    end 
  end
end
