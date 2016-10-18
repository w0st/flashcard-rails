require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }


  describe 'GET #index' do
    before { sign_in user }
    subject { get :index}

    it { is_expected.to render_template :index}
  end

  describe 'GET #show' do
    before { sign_in user }
    let!(:group) { create :group, user: user }
    subject { get :show, params: { id: group.id } }

    it { is_expected.to render_template :show}
  end

  describe 'GET #edit' do
    before { sign_in user }
    let!(:group) { create :group, user: user }
    subject { get :edit, params: { id: group.id } }

    it { is_expected.to render_template :edit}
  end

  describe 'GET #new' do
    before { sign_in user }
    subject { get :new}

    it { is_expected.to render_template :new}
  end

  describe 'POST #create' do
    before { sign_in user }
    context 'when valid attributes' do
      subject { post :create, params: { group: attributes_for(:group) } }

      it 'create' do
        expect { subject }.to change(Group, :count).by(1)
      end

      it 'redirect to the new group' do
        is_expected.to redirect_to(assigns[:group])
      end
    end

    context 'without name attribute' do
      before { sign_in user }
      subject { post :create, params: { group: attributes_for(:group, name: '') } }

      it 'does not create' do
        expect { subject }.to change(Group, :count).by(0)
      end

      it 'reloads new form' do
        is_expected.to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before { sign_in user }
    let!(:group) { create :group, user: user }
    let!(:group_valid_params) do
      {name: 'Another name group', description: 'Another description'}
    end
    let!(:group_invalid_name) do
      {name: '', description: 'Another description'}
    end

    context 'when valid attributes' do
      subject { put :update, params: { id: group.id, group: group_valid_params } }

      it 'edit' do
        expect { subject }.to change { group.reload.name }.to group_valid_params[:name]
      end

      it 'redirect to the group' do
        is_expected.to redirect_to(assigns[:group])
      end
    end

    context 'without name attribute' do
      subject { put :update, params: { id: group.id, group: group_invalid_name } }

      it 'does not edit' do
        subject
        expect(Group.find(group.id).name).not_to eq group_invalid_name[:name]
      end

      it 'reloads edit form' do
        is_expected.to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in user }
    let!(:group) { create :group, user: user }
    subject { delete :destroy, params: { id: group.id } }

    it 'destroys student' do
      expect { subject }.to change(Group, :count).by(-1)
    end

    it 'redirects to groups' do
      is_expected.to redirect_to(:groups)
    end
  end

  describe 'not owner of resource' do
    let(:notowner) {create :user, email: 'notowner@domain.com'}
    let!(:group) { create :group, user: user }
    let!(:group_valid_params) do
      {name: 'Another name group', description: 'Another description'}
    end
    before { sign_in notowner }

    it 'GET #show' do
      get :show, params: { id: group.id }
      is_expected.to redirect_to(:root)
      expect(flash[:alert]).to be_truthy
    end

    it 'POST #edit' do
      get :edit, params: { id: group.id }
      is_expected.to redirect_to(:root)
      expect(flash[:alert]).to be_truthy
    end

    it 'PUT #update' do
      put :update, params: { id: group.id, group: group_valid_params }
      is_expected.to redirect_to(:root)
      expect(flash[:alert]).to be_truthy
    end

    it 'DELETE #destroy' do
      delete :destroy, params: { id: group.id }
      is_expected.to redirect_to(:root)
      expect(flash[:alert]).to be_truthy
    end

  end
end
