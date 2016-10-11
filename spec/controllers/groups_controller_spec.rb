require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #index' do
    subject { get :index}

    it { is_expected.to render_template :index}
  end

  describe 'GET #show' do
    let!(:group) { create :group, user: user }
    subject { get :show, id: group.id }

    it { is_expected.to render_template :show}
  end

  describe 'GET #edit' do
    let!(:group) { create :group, user: user }
    subject { get :edit, id: group.id }

    it { is_expected.to render_template :edit}
  end

  describe 'GET #new' do
    subject { get :new}

    it { is_expected.to render_template :new}
  end

  describe 'POST #create' do
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
    let!(:group) { create :group, user: user }
    subject { delete :destroy, params: { id: group.id } }

    it 'destroys student' do
      expect { subject }.to change(Group, :count).by(-1)
    end

    it 'redirects to groups' do
      is_expected.to redirect_to(:groups)
    end
  end
end
