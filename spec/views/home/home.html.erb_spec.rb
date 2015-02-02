require 'spec_helper'
require 'rails_helper'

describe 'home/home' do
    before(:each) do
        render template: 'home/home.html.erb'
    end
    
    it 'should have test "Task App"' do
        expect(rendered).to include "Task App"
    end
end