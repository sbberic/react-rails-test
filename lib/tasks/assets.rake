namespace :react_on_rails do
  namespace :assets do
    desc "Creates non-digested symlinks for the assets in the public asset dir"
    task :symlink_non_digested_assets do
      ReactOnRails::AssetsPrecompile.new.symlink_non_digested_assets
    end

    desc "Cleans all broken symlinks for the assets in the public asset dir"
    task :delete_broken_symlinks do
      ReactOnRails::AssetsPrecompile.new.delete_broken_symlinks
    end
  end
end

# These tasks run as pre-requisites of assets:precompile.
# Note, it's not possible to refer to ReactOnRails configuration values at this point.
Rake::Task["assets:precompile"]
  .clear_prerequisites
  .enhance do
    Rake::Task["react_on_rails:assets:symlink_non_digested_assets"].invoke
    Rake::Task["react_on_rails:assets:delete_broken_symlinks"].invoke
  end