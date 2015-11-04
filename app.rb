require 'sinatra'
require 'stripe'

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  erb :index
end

get '/payment_frontend' do
  erb :payment_frontend
end


get '/payment_android' do
  erb :payment_android
end

post '/charge_frontend' do
  @amount = 5000

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Front-End Charge',
    :currency    => 'gbp',
    :customer    => customer.id,
    :receipt_email => customer.email
  )

  erb :charge_frontend
end

post '/charge_android' do
  @amount = 6000

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Android Charge',
    :currency    => 'gbp',
    :customer    => customer.id,
    :receipt_email => customer.email
  )

  erb :charge_android
end

__END__
