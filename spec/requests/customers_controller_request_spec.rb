require 'rails_helper'
RSpec.describe "CustomersControllers", type: :request do
  describe "get customers_path" do
    it "renders the index view" do
      FactoryBot.create_list(:customer, 10)
      get customers_path
      expect(response.status).to eq(200)
    end
  end
  describe "get customer_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      get customer_path(id: customer.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the customer id is invalid" do
      get customer_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to customers_path
    end
  end

  describe "get new_customer_path" do
    it "renders the :new template" do
      customer = FactoryBot.create(:customer)
      get new_customer_path
      expect(response.status).to eq(200)
    end
  end
  describe "get edit_customer_path" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      get edit_customer_path(id: customer.id)
      expect(response.status).to eq(200)
    end
  end
  describe "post customers_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      expect { post customers_path, {customer: customer_attributes}}.to change(Customer, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end
  describe "post customers_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { post customers_path, {customer: customer_attributes}}.to_not change(Customer, :count)
      expect(response.status).to eq(200)
    end
  end
  describe "put customer_path with valid data" do # questions here
    it "updates an entry and redirects to the show path for the customer" do
      customer = FactoryBot.create(:customer, email: "email@example.com")
      put customer_path(id: customer.id), params: {customer: { email: "newemail@example.com"}}
      customer.reload
      expect(customer.email).to eq("newemail@example.com")
      expect(response.status).to redirect_to customer_path(id: customer.id)
    end
  end

  describe "put customer_path with invalid data" do
    it "does not update the customer record or redirect" do
      #we want to test updating a customer record, so first we have to create the record
     customer = FactoryBot.create(:customer)
     #put is the operation for update.  The route for update includes
     #the customer.id.  We attempt to update the customer record with
     #a phone number of "123" which is invalid
     put customer_path(id: customer.id), params: {customer: { phone: "123"}}
     #we have to reload the customer object to see if what is in the database
     #has changed
     customer.reload
     #we expect it not to change because the phone number is invalid
     expect(customer.phone).to_not eq("123")
     #we don't expect a redirect, and therefore the HTTP status should be 200
     expect(response.status).to eq(200)
    end
  end

  describe "delete a customer record" do
    it "deletes a customer record" do
      customer = FactoryBot.create(:customer)
      delete customer_path(id: customer.id)
    #  expect(customer).to eq(nil)
      expect change(Customer, :count).from(1).to eq(0)
      expect(response.status).to eq(302)
    end
  end
end
