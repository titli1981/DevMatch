class PagesController < ApplicationController
  # Get request for '/' which is our hoe page
  def home                    #     id    name   price   created_at
    @basic_plan = Plan.find(1) #  (| 1  | basic | 0.0   | 2017-08-1... | 2017-08-1...)
    @pro_plan = Plan.find(2) # (| 2  | pro  | 10.0  | 2017-08-1... | 2017-08-14... )
  end
  def about
  end
end