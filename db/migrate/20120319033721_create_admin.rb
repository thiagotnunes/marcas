class CreateAdmin < ActiveRecord::Migration
  def up
    admin = User.new
    admin.username = 'admin'
    admin.password = 'admin123'
    admin.password_confirmation = 'admin123'
    admin.email = 'admin@admin.com'
    admin.role = 'admin'
    admin.save!
    admin.activate!
  end

  def down
    User.find_by_username('admin').destroy
  end
end
