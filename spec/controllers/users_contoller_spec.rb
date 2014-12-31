require 'spec_helper'
require 'rails_helper'

describe UsersController do
    it 'should respond to the new method call' do
        expect(@controller).to respond_to :new
    end

    describe '#new' do
        before(:each) do
            get :new
        end
        
        it 'should respond with success' do
            expect(response).to be_success
        end
        
        it 'should render the new view' do
            expect(response).to render_template :new
        end
    end
end