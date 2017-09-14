def debugit( *args, &block )
  it( *args, { driver: :poltergeist_debug, inspector: true }, &block )
end
