class ContactsController < ApplicationController
  def new
  @contact = Contact.new
  # creates a blank object {name: , email: , comments: }
  end
  def create
    @contact = Contact.new(contact_params) 
    # {name:Madhu, email:madhu.mishra@gmail.com, comment:hi}
    if @contact.save
       redirect_to new_contact_path, notice: "Message sent."
    else
       redirect_to new_contact_path, notice: "Error occured."
    end
  end
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end