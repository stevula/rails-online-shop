require 'rails_helper'

RSpec.describe ProductsController do
  let(:new_product) {FactoryGirl.build(:product)}


  describe '#index' do
    before(:each) do
      get :index
    end

    it 'responds with a status of 200' do
      expect(response.status).to eq(200)
    end

    it 'assigns the products instance variable' do
      expect(assigns(:products)).to be_an(ActiveRecord::Relation)
    end
  end

  describe '#create' do
    let(:params) {
                  {product: { name:        new_product.name,
                              description: new_product.description,
                              price:       new_product.price,
                              quantity:    new_product.quantity
                            }
                  }
                }

    context 'with valid parameters' do
      it 'increases products in the database by 1' do
        expect{post :create, params}.to change{Product.count}.by(1)
      end

      it 'responds with a status of 302' do
        post :create, params
        expect(response.status).to eq(302)
      end
    end
  end

  describe '#update' do
    let!(:existing_product) {FactoryGirl.create(:product)}
    let(:params) {{ product: { quantity: 42 }, id: existing_product.id}}

    context 'with valid parameters' do
      it 'updates the specified attribute' do
        patch :update, params
        expect(existing_product.reload.quantity).to eq(42)
      end

      it 'responds with a status of 302' do
        patch :update, params
        expect(response.status).to eq(302)
      end
    end
  end

  describe '#destroy' do
    let!(:existing_product) {FactoryGirl.create(:product)}

    context 'with valid parameters' do
      it 'should reduce the count of products' do
        expect{ delete :destroy, id: existing_product.id}.to change{Product.count}.by(-1)
      end

      it 'responds with a status of 302' do
        delete :destroy, id: existing_product.id
        expect(response.status).to eq(302)
      end
    end
  end
end
