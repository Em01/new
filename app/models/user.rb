class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :name, presence: true

  has_many :listings, dependent: :destroy
  # a listings existence depends on the existence of the user that created it
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"


  # def user_params
  #   params.require(:user).permit(::name, :email, :password, :password_confirmation, :remember_me, :stripe_token, :coupon)
  # before_save :update_stripe

  # def update_stripe
  #   return if email.include?(ENV['ADMIN_EMAIL'])
  #   return if email.include?('@example.com') and not Rails.env.production?
  #   if customer_id.nil?
  #     if !stripe_token.present?
  #       raise "Stripe token not present. Can't create account."
  #     end
  #     if coupon.blank?
  #       customer = Stripe::Customer.create(
  #         :email => email,
  #         :description => name,
  #         :card => stripe_token,
  #         :plan => roles.first.name
  #       )
  #     else
  #       customer = Stripe::Customer.create(
  #         :email => email,
  #         :description => name,
  #         :card => stripe_token,
  #         :plan => roles.first.name,
  #         :coupon => coupon
  #       )
  #     end
  #   else
  #     customer = Stripe::Customer.retrieve(customer_id)
  #     if stripe_token.present?
  #       customer.card = stripe_token
  #     end
  #     customer.email = email
  #     customer.description = name
  #     customer.save
  #   end
  #   self.last_4_digits = customer.cards.data.first["last4"]
  #   self.customer_id = customer.id
  #   self.stripe_token = nil
  # rescue Stripe::StripeError => e
  #   logger.error "Stripe Error: " + e.message
  #   errors.add :base, "#{e.message}."
  #   self.stripe_token = nil
  #   false
  # end

end