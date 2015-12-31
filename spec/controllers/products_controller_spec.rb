require 'rails_helper'

RSpec.describe ProductsController do
  include Devise::TestHelpers
  let(:good_params) {
                      {product: { name:        new_product.name,
                                  description: new_product.description,
                                  price:       new_product.price,
                                  quantity:    new_product.quantity
                                }
                      }
                    }

  let(:bad_params) {
                    {product: { name:        new_product.name,
                                description: new_product.description,
                                price:       "Dollar Bills",
                                quantity:    "Dog"
                              }
                    }
                  }

  let(:new_product) {FactoryGirl.build(:product)}
  let(:user) {FactoryGirl.create(:user)}

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

  describe '#show' do
    let!(:existing_product) {FactoryGirl.create(:product)}

    before(:each) do
      get :show, id: existing_product.id
    end

    it 'assigns the product instance variable' do
      expect(assigns(:product).id).to eq(existing_product.id)
    end

    it 'responds with a status of 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#new' do
    let!(:existing_product) {FactoryGirl.create(:product)}

    context 'when logged in' do
      it 'responds with a status of 200' do
        sign_in user
        get :new
        expect(response.status).to eq(200)
      end
    end

    context 'when not logged in' do
      it 'redirects to the products index' do
        get :new
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe '#edit' do
    let!(:existing_product) {FactoryGirl.create(:product)}

    context 'when logged in' do
      before(:each) do
        sign_in user
        get :edit, id: existing_product.id
      end

      it 'assigns the product instance variable' do
        expect(assigns(:product).id).to eq(existing_product.id)
      end

      it 'responds with a status of 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when not logged in' do
      it 'redirects to the products index' do
        get :new
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe '#create' do
    context 'when logged in' do
      before(:each) do
        sign_in user
      end

      context 'with valid parameters' do
        it 'increases products in the database by 1' do
          expect{post :create, good_params}.to change{Product.count}.by(1)
        end

        it 'responds with a status of 302' do
          post :create, good_params
          expect(response.status).to eq(302)
        end
      end

      context 'with invalid parameters' do
        it 'does not change the count of products' do
          expect{post :create, bad_params}.not_to change{Product.count}
        end

        it 'renders the new product page again' do
          post :create, bad_params
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when not logged in' do
      it 'redirects to the products index' do
        post :create, good_params
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe '#update' do
    let!(:update_product) {FactoryGirl.create(:product)}
    let(:good_params) {{ product: { quantity: 42 }, id: update_product.id }}

    context 'when logged in' do
      before(:each) do
        sign_in user
      end

      context 'with valid parameters' do
        it 'updates the specified attribute' do
          patch :update, good_params
          expect(update_product.reload.quantity).to eq(good_params[:product][:quantity])
        end

        it 'responds with a status of 302' do
          patch :update, good_params
          expect(response.status).to eq(302)
        end
      end

      context 'with invalid parameters' do
        let!(:bad_params)  {{ product: { quantity: "Dog" }, id: update_product.id }}

        it 'does not update the specified attribute' do
          expect{patch :update, bad_params}.not_to change{update_product}
        end

        it 'render the edit product page again' do
          patch :update, bad_params
          expect(response.status).to render_template(:edit)
        end
      end
    end

    context 'when not logged in' do
      it 'redirects to the products index' do
        patch :update, good_params
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe '#destroy' do
    let!(:existing_product) {FactoryGirl.create(:product)}

    context 'when logged in' do
      before(:each) do
        sign_in user
      end

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

    context 'when not logged in' do
      it 'redirects to the products index' do
        delete :destroy, id: existing_product.id
        expect(response).to redirect_to(products_path)
      end
    end
  end
end
