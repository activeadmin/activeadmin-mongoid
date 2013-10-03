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

    it 'creates and edits a new post' do
      # New
      click_on 'Posts'
      click_on 'New Post'
      fill_in 'Title', with: 'dhh screencast'
      fill_in 'Body', with: 'is still the best intro to rails'

      # Create
      click_on 'Create Post'

      within '.attributes_table.post' do
        page.should have_content('dhh screencast')
        page.should have_content('is still the best intro to rails')
      end

      # Edit
      click_on 'Edit Post'
      fill_in 'Title', with: 'DHH original screencast'

      # Update
      click_on 'Update Post'

      within '.attributes_table.post' do
        page.should have_content('DHH original screencast')
        page.should have_content('is still the best intro to rails')
      end

      # List
      within('.breadcrumb') { click_on 'Posts' }
      within '#index_table_posts' do
        page.should have_content('DHH original screencast')
        page.should have_content('is still the best intro to rails')
      end
    end

    context 'with 1 post' do

      before do
        Post.create!(title: 'Quick Brown Fox', body: 'The quick brown fox jumps over the lazy dog.', view_count: 5, admin_user: admin_user, other_user: other_user)

        click_on 'Posts'
      end

      describe 'filters' do
        describe 'string' do
          it 'searches by title' do
            fill_in 'Search Title', with: 'Brown'
            click_on 'Filter'

            within '#index_table_posts' do
              page.should have_content('Quick Brown Fox')
            end

            fill_in 'Search Title', with: 'dog'
            click_on 'Filter'
            page.should_not have_content('Quick Brown Fox')

            fill_in 'Search Title', with: ''
            click_on 'Filter'

            page.should have_content('Displaying 1 Post')
          end
        end

        describe 'date_range' do
          it 'searches by created_at range' do
            fill_in 'q[created_at_gte]', with: 1.day.ago.to_datetime.strftime("%Y-%m-%d")
            fill_in 'q[created_at_lte]', with: 2.days.from_now.to_datetime.strftime("%Y-%m-%d")
            click_on 'Filter'

            within '#index_table_posts' do
              page.should have_content('Quick Brown Fox')
            end

            fill_in 'q[created_at_gte]', with: 1.day.from_now.to_datetime.strftime("%Y-%m-%d")
            click_on 'Filter'
            page.should_not have_content('Quick Brown Fox')

            fill_in 'q[created_at_gte]', with: ''
            fill_in 'q[created_at_lte]', with: ''
            click_on 'Filter'

            page.should have_content('Displaying 1 Post')
          end
        end

        describe 'numeric' do
          it 'searches by created_at range', js: true do
            within '.filter_numeric' do
              find(:select).find('option[value=view_count_eq]').select_option
            end
            fill_in 'View count', with: '5'
            click_on 'Filter'

            within '#index_table_posts' do
              page.should have_content('Quick Brown Fox')
            end

            fill_in 'View count', with: '6'
            click_on 'Filter'
            page.should_not have_content('Quick Brown Fox')

            within '.filter_numeric' do
              find(:select).find('option[value=view_count_lt]').select_option
            end
            click_on 'Filter'

            within '#index_table_posts' do
              page.should have_content('Quick Brown Fox')
            end

            within '.filter_numeric' do
              find(:select).find('option[value=view_count_gt]').select_option
            end
            click_on 'Filter'
            page.should_not have_content('Quick Brown Fox')

            fill_in 'View count', with: '4'
            click_on 'Filter'

            within '#index_table_posts' do
              page.should have_content('Quick Brown Fox')
            end

            fill_in 'View count', with: ''
            click_on 'Filter'

            page.should have_content('Displaying 1 Post')
          end
        end
      end

      describe 'select' do
        it 'selects by admin_user' do
          select email, from: 'Admin user'
          click_on 'Filter'

          within '#index_table_posts' do
            page.should have_content('Quick Brown Fox')
          end

          select other_email, from: 'Admin user'
          click_on 'Filter'
          page.should_not have_content('Quick Brown Fox')

          select 'Any', from: 'Admin user'
          click_on 'Filter'

          page.should have_content('Displaying 1 Post')
        end
      end

      describe 'check_boxes' do
        it 'checks by other_user' do
          check email
          click_on 'Filter'
          page.should_not have_content('Quick Brown Fox')

          check other_email
          click_on 'Filter'

          within '#index_table_posts' do
            page.should have_content('Quick Brown Fox')
          end

          uncheck email
          uncheck other_email
          click_on 'Filter'

          page.should have_content('Displaying 1 Post')
        end
      end
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

            pagination_information = page.find('.pagination_information').native.to_s.gsub(nbsp,' ').gsub('&#160;', ' ')
            pagination_information.should include(display_total_text.gsub('&nbsp;', ' '))
          end
        end
      end
    end # context 'with 100 posts'

  end

end
