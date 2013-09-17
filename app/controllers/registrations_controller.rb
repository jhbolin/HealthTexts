class RegistrationsController < Devise::RegistrationsController
  def update
    attrs = params[:user].dup

    if attrs[:phone_number_country_code]
      attrs[:phone_number] = "#{attrs.delete(:phone_number_country_code)}#{attrs.delete(:phone_number_area_code)}#{attrs.delete(:phone_number_suffix)}"
    end

    health_condition_ids = Array(attrs.delete(:health_condition_ids)).map(&:to_i)
    current_ids = current_user.health_condition_subscriptions.map(&:health_condition_id)
    ids_to_add = health_condition_ids - current_ids
    ids_to_remove = current_ids - health_condition_ids

    ids_to_add.each do |id|
      current_user.health_condition_subscriptions.build :health_condition_id => id
    end

    current_user.health_condition_subscriptions.each do |hcs|
      if ids_to_remove.include?(hcs.health_condition_id)
        hcs.mark_for_destruction
      end
    end

    current_user.update_attributes!(attrs)

    redirect_to :back
  end
end