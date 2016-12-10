module Ops
  class DatabaseBackupJob < ApplicationJob
    queue_as :default

    def perform(*args)
      db = Rails.configuration.database_configuration[Rails.env]
      root = Rils.root.join('tmp', 'backup', 'database')
      FileUtils.mkdir_p root

      `pg_dump --dbname=postgresql://#{db.fetch 'username'}:#{db.fetch 'password'}@#{db.fetch 'host'}:#{db.fetch 'port'}/#{db.fetch 'database'} | gzip > #{File.join root, "#{Time.now.strftime('%Y%m%d%H%M%S%L')}.sql.gz"}`

    end
  end
end
