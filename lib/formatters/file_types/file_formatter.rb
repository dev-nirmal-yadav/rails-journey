# frozen_string_literal: true

# File Formatter.
class FileFormatter
  def self.call(args)
    content = if args[:header]
                "********** #{args[:data]} **********\n"
              elsif args[:sub_header]
                "\n---------- #{args[:data]} ---------\n"
              elsif args[:footer]
                "\n*************************************"
              else
                "\n\s\s#{args[:data]}\n"
              end
    File.open('log/output.txt', args[:operation]&.to_s || 'a') { |file| file << content }
  end
end
