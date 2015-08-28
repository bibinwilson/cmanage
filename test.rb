include ActionController::Live

  private

  def follow_log
    begin
      stdin, stdout, stderr, wait_thread = Open3.popen3("tail -F -n 0 #{Rails.root.join('log', 'development.log')}")

      stdout.each_line do |line|
        yield line
      end

    rescue IOError

    ensure
      stdin.close
      stdout.close
      stderr.close
      Process.kill('HUP', wait_thread[:pid])
      logger.info("Killing Tail pid: #{wait_thread[:pid]}")
    end
  end