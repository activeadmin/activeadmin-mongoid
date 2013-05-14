require 'spec_helper'

describe 'browse the test app' do
  before { Mongoid.purge! }
  before { visit '/admin' }

  it 'does something' do
    I18n.backend.reload!

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

    page.should have_content('Displaying 1 Post')
  end
end
