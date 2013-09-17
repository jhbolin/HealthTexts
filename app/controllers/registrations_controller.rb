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

    current_user.attributes = attrs

    phone_number_changed = current_user.phone_number_changed?

    if phone_number_changed
      client = Twilio::REST::Client.new 'AC6d2810c695855bd27d742a823f6b907e', '82d7a06dfed69448a6d1c1c05c57cf5a'

      account = client.account

      account.sms.messages.create(
        :from => "+14158020123",
        :to => "+#{current_user.phone_number}",
        :body => "Welcome, #{current_user.name}. Thanks for subscribing to HealthTexts.com, where we empower you to take control of your health.",
      )
    end

    current_user.save!

    if phone_number_changed
      flash.notice = 'Thank you for your subscription. You will receive a confirmation text message.'
    end

    redirect_to :back
  end
end