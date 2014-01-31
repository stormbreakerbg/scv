desc 'Displays the file changes in the working directory'
arg_name ''
command :diff do |c|
  c.action do |global_options, options, args|
    repository = global_options[:repository]
    commit     = repository.resolve(:head, :commit)
    status     = repository.status commit.id,
                                   ignore: [/^\.|\/\./]

    output do
      status.each do |_, file_list|
        file_list.each do |file_path|
          changeset = repository.file_difference file_path, commit.id
          SCV::Formatters::Changeset.print file_path, changeset
        end
      end
    end
  end
end