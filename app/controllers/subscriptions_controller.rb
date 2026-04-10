class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workspace

  def new
    @plans = [
      { name: "Free", price: 0, plan: "free", features: ["Up to 3 projects", "Basic features"] },
      { name: "Pro", price: 9, plan: "pro", features: ["Unlimited projects", "Priority support"] },
      { name: "Business", price: 29, plan: "business", features: ["Unlimited projects", "Team features", "Advanced analytics"] }
    ]
  end

  def create
    plan = params[:plan]

    if plan == "free"
      @workspace.create_subscription(plan: "free", status: "active")
      redirect_to workspace_path(@workspace), notice: "You are on the Free plan!"
      return
    end

    customer = Stripe::Customer.create(email: current_user.email)

    session = Stripe::Checkout::Session.create(
      customer: customer.id,
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "usd",
          product_data: { name: "TaskFlow #{plan.capitalize} Plan" },
          unit_amount: plan == "pro" ? 900 : 2900,
          recurring: { interval: "month" }
        },
        quantity: 1
      }],
      mode: "subscription",
      success_url: workspace_url(@workspace) + "?success=true",
      cancel_url: new_workspace_subscription_url(@workspace)
    )

    @workspace.create_subscription(
      stripe_customer_id: customer.id,
      stripe_subscription_id: session.id,
      plan: plan,
      status: "active"
    )

    redirect_to session.url, allow_other_host: true
  end

  private

  def set_workspace
    @workspace = current_user.workspaces.find(params[:workspace_id])
  end
end