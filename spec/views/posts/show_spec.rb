require 'rails_helper'

describe 'posts/show.html.slim' do
  let(:post) { create :post }

  before do
    assign(:post, post)
    render
  end

  it('displays title'){
    expect(rendered).to have_selector('h1', text:post.title)
  }
  it('displays body'){
    expect(rendered).to have_selector('p', text: post.body)
  }

end
