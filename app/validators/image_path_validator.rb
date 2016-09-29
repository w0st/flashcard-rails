
class ImagePathValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /^[\w]+(\.(?i)(jpg|png|gif|bmp))$/ =~ value
      record.errors[attribute] << (options[:message] || 'wrong image path')
    end
  end
end