# coding: utf-8
require 'spec_helper'
require 'activeadmin'

describe 'browse the test app' do
  let(:password) { 'foobar•secret' }
  let(:email) { 'john@doe.com' }
  let(:admin_user) do
    AdminUser.where(email: email).first || AdminUser.create!(email: email, password: password)
  end
  let(:other_email) { 'jane@doe.com' }
  let(:other_user) do
    AdminUser.where(email: other_email).first || AdminUser.create!(email: other_email, password: password)
  end

  before do
    Mongoid.purge!
    expect(admin_user).to be_persisted
    expect(other_user).to be_persisted
  end

  context 'when authorized' do
    before do
      visit '/admin'

      I18n.t('active_admin.devise.login.submit').should eq('Login')

      # Auth
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_on 'Login'
    end

    context 'with 100 posts' do
      let(:per_page) { 30 }
      let(:posts_size) { 100 }

      before do
        posts_size.times { |n|
          Post.create!(title: "Quick Brown Fox #{n}", body: 'The quick brown fox jumps over the lazy dog.', view_count: 5, admin_user: admin_user, other_user: other_user)
        }

        click_on 'Posts'
      end

      describe "paginator" do
        it "must have paginator with 4 pages" do
          page.should have_css('.pagination > .page.current')
          page.all(:css, '.pagination > .page').size.should == 4
        end

        it "must show each page correctly" do
          # temprorary go to page 2
          page.find('.pagination > .page > a', text: '2').click

          nbsp = Nokogiri::HTML("&nbsp;").text

          (1..4).each do |page_number|
            page.find('.pagination > .page > a', text: page_number).click
            page.find('.pagination_information').should have_content('Displaying Posts')

            offset = (page_number - 1) * per_page
            collection_size = [per_page, posts_size - (page_number - 1) * per_page].min

            display_total_text = I18n.t 'active_admin.pagination.multiple', :model => 'Posts', :total => posts_size,
                :from => offset + 1, :to => offset + collection_size

            pagination_information = page.find('.pagination_information').native.to_s.gsub(nbsp,' ')
            pagination_information.should include(display_total_text.gsub('&nbsp;', ' '))
          end
        end
      end

    end
  end

end
