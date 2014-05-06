require "net/ftp"
module ChinaUnicomApi
  class FtpSync
    #this code reference https://github.com/stevo/ftp-transfer/blob/master/lib/ftp_transfer.rb
    def initialize
      begin
        @ftp = Net::FTP.new
        @ftp.connect(ENV['CUAPI_FTP_SERVER'], ENV['CUAPI_FTP_PORT'])
        @ftp.login(ENV['CUAPI_FTP_NAME'], ENV['CUAPI_FTP_PASSWD'])
        @ftp.passive = true
        RAILS_DEFAULT_LOGGER.info "You have been succesfully connected to the ftp server"
        @ftp
      rescue Exception => e
        error_message(e)
      end
    end
    

    # put local file to server, remotefile is optional (it specify the name of sending file on the server)
    # return true if execute correctly
    # send_file("C:\Clawfinger.mp3")
    # send_file("C:\Clawfinger.mp3", "mp3\Clawfinger77.mp3")
    def send_file(file, remotefile = File.basename(file))
      begin
        @ftp.putbinaryfile(file, remotefile)
        return true
      rescue Exception => e
        error_message(e)
        return false
      end
    end
    
    # sending string to remote file on server
    # send_text("text text text text text", "file.txt")
    def send_text(text, remotefile)
      begin
        @ftp.put_text(text, remotefile)
        return true
      rescue
        return false
      end
    end

    # get file from a server
    # return true if execute correctly
    # retrieve_file("Clawfinger.mp3")
    def retrieve_file(file)
      begin
        @ftp.getbinaryfile(file)
        return true
      rescue Exception => e
        error_message(e)
        return false
      end
    end

    # read file directly from a server
    # return true if execute correctly
    # read_remote_file("readme.txt)
    def read_remote_file(file)
      begin
        result = ""
        @ftp.retrbinary("RETR #{file}", 1024) {|line| result += line if line != nil}
      rescue Exception => e
        error_message(e)
      ensure
        return result
      end
    end

    # delete file from a server
    # return true if execute correctly
    # remove_file("readme.txt")
    def remove_file(file)
      begin
        @ftp.delete(file)
        return true
      rescue Exception => e
        error_message(e)
        return false
      end
    end

    # creates a remote directory
    # make_dir("my_new_directory")
    def make_dir(dirname)
      begin
        @ftp.mkdir(dirname)
        return true
      rescue 
        return false
      end
    end

    # removes a file from the server to another location on the server (or just change name of the file)
    # rename("file.txt", "folder/new_name.txt")
    def rename(fromname, toname)
      begin
        @ftp.rename(fromname, toname)
        return true
      rescue
        return false
      end
    end

    # returns the size of the given (remote) filename
    def size(filename)
      begin
        @ftp.size(filename)
      rescue
        return false
      end
    end

    # returns an array of filenames in the remote directory
    # you can specify directory if you want
    # list
    # list("documents/")
    def list(directory = nil)
      @ftp.nlst(directory)
    end

    # closes the connection, further operations are impossible
    # return true if executed correctly
    def close
      @ftp.close
      @ftp.closed?
    end

    
    protected
    def error_message(e)
      raise "Error has occured in FtpTransfer: #{e.message}"
    end
  end
end