# coding: utf-8
require 'spec_helper'
require 'activeadmin'

describe 'browse the test app' do
  let(:password) { 'foobar•secret' }
  let(:email) { 'john@doe.com' }

  before do
    Mongoid.purge!
    AdminUser.create! email: email, password: password
  end
  before { visit '/admin' }

  it 'does something' do
    I18n.t('active_admin.devise.login.submit').should eq('Login')

    # Auth
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Login'

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

    # Filter
    fill_in 'Search Title', with: 'original'
    click_on 'Filter'

    within '#index_table_posts' do
      page.should have_content('DHH original screencast')
    end

    fill_in 'Search Title', with: 'orizinal'
    click_on 'Filter'
    page.should_not have_content('DHH original screencast')

    fill_in 'Search Title', with: ''
    click_on 'Filter'

    page.should have_content('Displaying 1 Post')
  end
end
