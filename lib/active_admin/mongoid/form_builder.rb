require 'active_admin/form_builder'

class ActiveAdmin::FormBuilder
  def inputs(*args, &block)
    # Store that we are creating inputs without a block
    @inputs_with_block = block_given? ? true : false
    content = with_new_form_buffer do
      super
      # form_buffers.last
    end
    form_buffers.last << content.html_safe
  end
end
